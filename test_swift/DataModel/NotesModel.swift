//
//  NotesModel.swift
//  test_swift
//
//  Created by 孔令文 on 2018/5/12.
//  Copyright © 2018年 孔令文. All rights reserved.
//

import Foundation
import UIKit

class NotesModel: NSObject {
    
    public let TYPE_MINIM: String = "2"
    public let TYPE_CROTCHET: String = "4"
    public let TYPE_QUAVER: String = "8"
    public let TYPE_DEMIQUAVER: String = "16"
    
    public let MINIM_WIDTH: Float = 15 * 1.5 * 1.5 * 1.5;
    public let CROTCHETA_WIDTH: Float = 15 * 1.5 * 1.5;
    public let QUAVER_WIDTH: Float = 15 * 1.5;
    public let DEMIQUAVER_WIDTH: Float = 15;
    
    private static var instance: NotesModel? = nil
    
    let fileManager: FileManager
    let documentPath: String
    let tmpPath: String
    var guitarNotesFiles: NSMutableArray = NSMutableArray()
    var rootNoteDic: NSMutableDictionary? = nil
    var currEditNote: EditNoteInfo?
    var notesSizeArray: NSMutableArray? = nil
    
    static func getInstance() -> NotesModel {
        if instance == nil {
            instance = NotesModel.init()
        }
        return instance!
    }
    
    private override init() {
        fileManager = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        documentPath = paths[0] + "/"
        tmpPath = NSTemporaryDirectory()
        currEditNote = EditNoteInfo(barNo: 0, noteNo: 0, stringNo: 1)
        
        let path: String = Bundle.main.path(forResource: "天空之城", ofType: "plist")!
        NSLog("path %@", path)
        NSLog("document: %@", documentPath)
        
        try? fileManager.copyItem(atPath: path, toPath: documentPath + "天空之城.plist")
        
        do {
            let array = try fileManager.contentsOfDirectory(atPath: paths[0])
            for fileName in array {
                if fileName.hasSuffix(".plist") {
                    guitarNotesFiles.add(fileName)
                }
            }
        } catch let error as NSError {
            print("get file path error : \(error)")
        }
    }
    
    override func copy() -> Any {
        return self
    }
    
    override func mutableCopy() -> Any {
        return self
    }
    
    
    func getGuitarNotesFileNum() -> Int {
        return guitarNotesFiles.count
    }
    
    func getGuitarNotesFileName(index: Int) -> String {
        return guitarNotesFiles.object(at: index) as! String
    }
    
    func setGuitarNotesWithNotesTitle(noteTitle: String) {
        rootNoteDic = getGuitarNotesFromGuitarNotesTitle(guitarNotesTitle: noteTitle)
    }
    
    func getGuitarNotesFromGuitarNotesTitle(guitarNotesTitle: String) -> NSMutableDictionary {
        let plistPath = documentPath + guitarNotesTitle
        let rootDic = NSMutableDictionary(contentsOfFile: plistPath)
        return rootDic!
    }
    
    func getRootNotes() -> NSMutableDictionary {
        return rootNoteDic!
    }
    
    func getBarNum() -> Int {
        return getBarNoDataArray().count
    }
    
    func getBarNoDataArray() -> NSMutableArray {
        return rootNoteDic!.value(forKey: "GuitarNotes") as! NSMutableArray
    }
    
    func getNoteNoDataArray(barNo: Int) -> NSMutableArray {
        let barNoDataArray: NSMutableArray? = getBarNoDataArray()
        return barNoDataArray!.object(at: barNo) as! NSMutableArray
    }
    
    func getNoteNoData(barNo: Int, noteNo: Int) -> NSMutableDictionary {
        let noteNoDataArray: NSMutableArray? = getNoteNoDataArray(barNo: barNo)
        return noteNoDataArray!.object(at: noteNo) as! NSMutableDictionary
    }
    
    func getNotesArray(barNo: Int, noteNo: Int) -> NSMutableArray {
        let noteNoData: NSMutableDictionary? = getNoteNoData(barNo: barNo, noteNo: noteNo)
        return noteNoData?.value(forKey: "noteArray") as! NSMutableArray
    }
    
    func getNoteType(barNo: Int, noteNo: Int) -> String {
        let noteNoData: NSMutableDictionary? = getNoteNoData(barNo: barNo, noteNo: noteNo)
        return noteNoData?.value(forKey: "NoteType") as! String
    }
    
    func getNoteData(barNo: Int, noteNo: Int, stringNo: Int) -> NSMutableDictionary? {
        var returnNote: NSMutableDictionary? = nil
        let notesArray: NSMutableArray? = getNotesArray(barNo: barNo, noteNo: noteNo)
        for note in notesArray! {
            let tmpStringNo = DictDataUtil.getStringNo(note: note as! NSMutableDictionary)
            if tmpStringNo == stringNo {
                returnNote = note as? NSMutableDictionary
                break
            }
        }
        return returnNote
    }
    
    func getCurrEditNote() -> EditNoteInfo {
        return currEditNote!
    }
    
    func setCurrEditNo(barNo: Int, noteNo: Int, stringNo: Int) {
        currEditNote!.barNo = barNo
        currEditNote!.noteNo = noteNo
        currEditNote!.stringNo = stringNo
    }
    
    func changeEditNoteType(noteType: String) {
        let barNo = currEditNote!.barNo
        let noteNo = currEditNote!.noteNo
        
        let noteNoData: NSMutableDictionary? = getNoteNoData(barNo: barNo, noteNo: noteNo)
        noteNoData?.setValue(noteType, forKey: "NoteType")
    }
    
    func changeEditNoteFretNo(fretNo: Int) {
        
        // 获取音符编辑框所在的位置，包括小节序号、音符序号、吉他弦号
        let barNo = currEditNote!.barNo
        let noteNo = currEditNote!.noteNo
        let stringNo = currEditNote!.stringNo
        
        let notesArray = getNotesArray(barNo: barNo, noteNo: noteNo)
        let editNote = getNoteData(barNo: barNo, noteNo: noteNo, stringNo: stringNo)
        if editNote == nil { // 当音符编辑框所在位置没有音符时，添加新的音符
            let newNote = NSMutableDictionary()
            DictDataUtil.setStringNo(note: newNote, stringNo: stringNo)
            DictDataUtil.setFretNo(note: newNote, fretNo: fretNo)
            DictDataUtil.setPlayType(note: newNote, playType: DictDataUtil.getNoteType(noteNoData: notesArray.object(at: 0) as! NSMutableDictionary))
            notesArray.add(newNote)
        } else { // 当音符编辑框所在位置有音符时，修改原有音符
            var newFretNo = fretNo
            let oldFretNo = DictDataUtil.getFretNo(note: editNote!)
            // 当原有音符为1或2时，将原有音符乘以10再加上输入音符，结果作为新的音符
            if oldFretNo == 1 || oldFretNo == 2 {
                newFretNo += oldFretNo * 10
            }
            DictDataUtil.setFretNo(note: editNote!, fretNo: newFretNo)
        }
        
        // 如果修改位置存在空白占位音符，则删除空白占位音符
        removeBlankNote();
    }
    
    func removeBlankNote() {
        // 获取音符编辑框所在的位置，包括小节序号、音符序号、吉他弦号
        let barNo = currEditNote!.barNo
        let noteNo = currEditNote!.noteNo
        
        let notesArray = getNotesArray(barNo: barNo, noteNo: noteNo);
        let note: NSMutableDictionary? = notesArray.object(at: 0) as? NSMutableDictionary
        let tmpFretNo = DictDataUtil.getFretNo(note: note!)
        let tmpStringNo = DictDataUtil.getStringNo(note: note!)
        if (tmpFretNo == -1 && tmpStringNo == -1) {
            notesArray.remove(note!);
        }
    }
    
    func insertBlankNoteAtBarNo(barNo: Int) {
        let noteNoArray = getNoteNoDataArray(barNo: barNo);
        let noteNoData = NSMutableDictionary()
        let note = NSMutableDictionary()
        DictDataUtil.setStringNo(note: note, stringNo: -1)
        DictDataUtil.setFretNo(note: note, fretNo: -1)
        DictDataUtil.setPlayType(note: note, playType: "Normal")
        let notesArray = NSMutableArray()
        notesArray.add(note)
        DictDataUtil.setNotesArray(noteNoData: noteNoData, notesArray: notesArray)
        noteNoArray.add(noteNoData);
    }
    
    func addBarNoDataAtIndex(barNoData: NSMutableArray, barNo: Int) {
        let barNoDataArray: NSMutableArray? = getBarNoDataArray()
        barNoDataArray?.insert(barNoDataArray!, at: barNo)
    }
    
    func removeBarNoData(barNo: Int) {
        let barNoDataArray: NSMutableArray? = getBarNoDataArray();
        barNoDataArray!.remove(barNo);
        if (barNoDataArray!.count > 0) {
            if (barNo == 0) {
                setCurrEditNo(barNo: 0, noteNo: 0, stringNo: 1);
            } else {
                setCurrEditNo(barNo: barNo - 1, noteNo: 0, stringNo: 1);
            }
        } else {
            addBlankBarNoData(barNo: -1);
        }
    }
    
    func addBlankBarNoData(barNo: Int) {
        let noteNoDataArray = NSMutableArray();
        addBarNoDataAtIndex(barNoData: noteNoDataArray, barNo: barNo + 1)
        addBlankNoteNoData(barNo: barNo + 1, noteNo: 0);
    
        setCurrEditNo(barNo: barNo + 1, noteNo: 0, stringNo: 1)
    }
    
    func addBlankNoteNoData(barNo: Int, noteNo: Int) {
        let noteNoData = NSMutableDictionary();
        DictDataUtil.setNoteType(noteNoData: noteNoData, noteType: "4")
        let notesArray = NSMutableArray();
        let note = NSMutableDictionary();
        DictDataUtil.setStringNo(note: note, stringNo: -1)
        DictDataUtil.setFretNo(note: note, fretNo: -1)
        DictDataUtil.setPlayType(note: note, playType: "Normal")
        notesArray.add(note);
        DictDataUtil.setNotesArray(noteNoData: noteNoData, notesArray: notesArray)
        addNoteNoDataAtIndex(noteNoData: noteNoData, barNo: barNo, noteNo: noteNo);
    }
    
    func addNoteNoDataAtIndex(noteNoData: NSMutableDictionary, barNo: Int, noteNo: Int) {
        let noteNoDataArray: NSMutableArray = getNoteNoDataArray(barNo: barNo);
        noteNoDataArray.insert(noteNoData, at: noteNo)
    }
    
    func removeNoteNoData(barNo: Int, noteNo: Int) {
        let noteNoDataArray: NSMutableArray? = getNoteNoDataArray(barNo: barNo);
        noteNoDataArray!.remove(noteNo);
        
        if (noteNoDataArray!.count == 0) {
            removeBarNoData(barNo: barNo);
        if (barNo > 0) {
            setCurrEditNo(barNo: barNo - 1, noteNo: 0, stringNo: 1)
            } else {
                setCurrEditNo(barNo: barNo, noteNo: 0, stringNo: 1)
            }
        } else {
            if (noteNo != 0) {
                setCurrEditNo(barNo: barNo, noteNo: noteNo - 1, stringNo: 1)
            }
        }
    }
    
    
    func calBarSizeWithNoteNoArray(noteNoDataArray: NSMutableArray, currentMinimWidth: Float, currentCrotchetaWidth: Float, currentQuaverWidth: Float, currentDemiquaverWidth: Float) -> BarSize {
    
        // 当前小节宽度初始化
        var barWidth: Float = 0
    
        // 音符个数初始化
        var minimNum: Int = 0
        var crotchetaNum: Int = 0
        var quaverNum: Int = 0
        var demiquaverNum: Int = 0
    
        // 统计音符总数
        var noteType: String = ""
        let noteNoCount: Int = noteNoDataArray.count
        for noteNo in 0 ..< noteNoCount {
            noteType = DictDataUtil.getNoteType(noteNoData: noteNoDataArray.object(at: noteNo) as! NSMutableDictionary)
            switch (noteType) {
            case TYPE_MINIM:
                minimNum += 1
            case TYPE_CROTCHET:
                crotchetaNum += 1
            case TYPE_QUAVER:
                quaverNum += 1
            case TYPE_DEMIQUAVER:
                demiquaverNum += 1
            default:
                NSLog("noteType ERROR")
            }
        }
    
        // 最后一个音符宽度
        switch (noteType) {
        case TYPE_MINIM:
            minimNum += 1
        case TYPE_CROTCHET:
            crotchetaNum += 1
        case TYPE_QUAVER:
            quaverNum += 1
        case TYPE_DEMIQUAVER:
            demiquaverNum += 1
        default:
            NSLog("noteType ERROR")
        }
    
        // 计算小节宽度总和
        barWidth += Float(minimNum) * currentMinimWidth
        barWidth += Float(crotchetaNum) * currentCrotchetaWidth
        barWidth += Float(quaverNum) * currentQuaverWidth
        barWidth += Float(demiquaverNum) * currentDemiquaverWidth
    
        // 保存结果并返回
        let barSize = BarSize()
        barSize.barWidth = barWidth
        barSize.minimNum = minimNum
        barSize.crotchetaNum = crotchetaNum
        barSize.quaverNum = quaverNum
        barSize.demiquaverNum = demiquaverNum
    
        return barSize
    }
    
    func getNotesSizeArray() -> NSMutableArray {
        return notesSizeArray!
    }
    
    func getLineSize(lineNo: Int) -> LineSize? {
        if (lineNo >= notesSizeArray!.count) {
            NSLog("lineNo(\(lineNo)) is out of size(\(notesSizeArray!.count))");
            return nil;
        }
        return notesSizeArray!.object(at: lineNo) as? LineSize;
    }
    
    func getBarWidthArray(lineNo: Int) -> NSMutableArray {
        return getLineSize(lineNo: lineNo)!.barWidthArray;
    }
    
    func calNotesSize() {
    
        var minimNum: Int = 0;           // 单个小节二分音符个数
        var crotchetaNum: Int = 0;       // 单个小节四分音符个数
        var quaverNum: Int = 0;          // 单个小节八分音符个数
        var demiquaverNum: Int = 0;      // 单个小节十六分音符个数
    
        var minimSum: Int = 0;           // 整行二分音符总数
        var crotchetaSum: Int = 0;       // 整行四分音符总数
        var quaverSum: Int = 0;          // 整行八分音符总数
        var demiquaverSum: Int = 0;      // 整行十六分音符总数
    
        let lineTotalWidth: Float = getLineTotalWidth();
    
        var barSize: BarSize;
        var isFirstBarInLine: Bool = true;
        var startBarNo: Int = 0;         // 每行第一小节的barNo
        var lineBarWidth: Float = 0;     // 行所有小节总宽度
        let barNoArray: NSMutableArray? = getBarNoDataArray();
        notesSizeArray!.removeAllObjects();
        for var barNo in 0 ..< barNoArray!.count {
            barSize = calBarSizeWithNoteNoArray(noteNoDataArray: barNoArray?.object(at: barNo) as! NSMutableArray, currentMinimWidth: MINIM_WIDTH, currentCrotchetaWidth: CROTCHETA_WIDTH, currentQuaverWidth: QUAVER_WIDTH, currentDemiquaverWidth: DEMIQUAVER_WIDTH)
        
            minimNum = barSize.minimNum
            crotchetaNum = barSize.crotchetaNum
            quaverNum = barSize.quaverNum
            demiquaverNum = barSize.demiquaverNum
        
            // 计算小节宽度总和
            lineBarWidth += barSize.barWidth
        
            // 当前行所有小节宽度总和小于吉他谱宽度时，累加音符数
            if (lineBarWidth < lineTotalWidth) {
                minimSum += minimNum
                crotchetaSum += crotchetaNum
                quaverSum += quaverNum
                demiquaverSum += demiquaverNum
            
                isFirstBarInLine = false
            } else {
        
                if (isFirstBarInLine) {
                minimSum += minimNum
                crotchetaSum += crotchetaNum
                quaverSum += quaverNum
                demiquaverSum += demiquaverNum
                }
                let lineSize: LineSize = calLineSize(startBarNo: startBarNo, endBarNo: barNo, minimSum: minimSum, crotchetaSum: crotchetaSum, quaverSum: quaverSum, demiquaverSum: demiquaverSum)
                notesSizeArray!.add(lineSize)
            
                // 重置参数
                // 下一行小节开始序号，设置为丢弃的小节序号
                // 小节序号减一，从丢弃的小节序号重新开始计算
                startBarNo = barNo;
                if (!isFirstBarInLine) {
                    barNo -= 1
                }
            
                // 行所有小节宽度初始值设置为丢弃小节的宽度
                lineBarWidth = 0
                minimSum = 0
                crotchetaSum = 0
                quaverSum = 0
                demiquaverSum = 0
            
                isFirstBarInLine = true
        
            }
        }
    
        // 最后一行，以最小音符长度计算尺寸
    
        // 计算行小节宽度
        let lineSize: LineSize = calLineSize(startBarNo: startBarNo, endBarNo: barNoArray!.count, minimSum: minimSum, crotchetaSum: crotchetaSum, quaverSum: quaverSum, demiquaverSum: demiquaverSum)
        notesSizeArray!.add(lineSize);
    
    }
    
    func calLineSize(startBarNo: Int, endBarNo: Int, minimSum: Int, crotchetaSum: Int, quaverSum: Int, demiquaverSum: Int) -> LineSize {
    
        let guitarNotesWidth: Float = getLineTotalWidth()
        let barNoArray: NSMutableArray? = getBarNoDataArray()
    
        let lineSize: LineSize = LineSize()
        lineSize.startBarNo = startBarNo
        lineSize.barNum = endBarNo - startBarNo
    
        // 音符个数减去最后要丢弃的一小节的音符数，重新计算音符宽度
        var tmpData: Float = Float(demiquaverSum)
        tmpData += Float(quaverSum) * 1.5
        tmpData += Float(crotchetaSum) * 1.5 * 1.5
        tmpData += Float(minimSum) * 1.5 * 1.5 * 1.5
        let currentDemiquaverWidth: Float = guitarNotesWidth / tmpData
        let currentQuaverWidth: Float = currentDemiquaverWidth * 1.5
        let currentCrotchetaWidth: Float = currentQuaverWidth * 1.5
        let currentMinimWidth: Float = currentCrotchetaWidth * 1.5
        
        lineSize.demiquaverWidth = currentDemiquaverWidth
        lineSize.quaverWidth = currentQuaverWidth
        lineSize.crotchetaWidth = currentCrotchetaWidth
        lineSize.minimWidth = currentMinimWidth
    
        // 通过计算得到的音符宽度重新计算小节宽度，保存在数组中
        var lineBarWidth: Float = 0
        var barSize: BarSize
        let barWidthArray: NSMutableArray = NSMutableArray()
        barWidthArray.add(0.0)
        for i in startBarNo ..< endBarNo - 1 {
            barSize = calBarSizeWithNoteNoArray(noteNoDataArray: barNoArray?.object(at: i) as! NSMutableArray, currentMinimWidth: currentMinimWidth, currentCrotchetaWidth: currentCrotchetaWidth, currentQuaverWidth: currentQuaverWidth, currentDemiquaverWidth: currentDemiquaverWidth)
            lineBarWidth += barSize.barWidth;
            barWidthArray.add(lineBarWidth);
        }
        barWidthArray.add(guitarNotesWidth);
        lineSize.barWidthArray = barWidthArray
    
        return lineSize;
    }
    
    func getLineTotalWidth() -> Float {
        let guitarNotesWidth: Float = Float(UIScreen.main.bounds.width)
        return guitarNotesWidth
    }
    
    func getFlatTime() -> Float {
    
        var flatTime: Float = 0;
        let tempo: String = DictDataUtil.getFlat(noteNoData: rootNoteDic!)
        let totalNoteType: String = String(tempo.split(separator: "/")[1])
        switch (totalNoteType) {
        case TYPE_MINIM:
            flatTime = 0.5;
        case TYPE_CROTCHET:
            flatTime = 0.25;
        case TYPE_QUAVER:
            flatTime = 0.125;
        case TYPE_DEMIQUAVER:
            flatTime = 0.0625;
        default:
            NSLog("noteType ERROR")
        }
        return flatTime;
    }
    
    func getFlatTimeTotal() -> Float {
        var flatTimeTotal: Float = 0
        let flatTime: Float = getFlatTime()
        let tempo: String = DictDataUtil.getFlat(noteNoData: rootNoteDic!)
        let beatsPerBar: Int = Int(tempo.split(separator: "/")[0])!
        flatTimeTotal = flatTime * Float(beatsPerBar);
        return flatTimeTotal;
    }
    
    func checkBarStateAtBarNo(barNo: Int) -> Bool {
        var noteType: Float = 0;
        var noteTypeSum: Float = 0;
        let flatTimeTotal: Float = getFlatTimeTotal();
        let noteNoArray: NSMutableArray? = getNoteNoDataArray(barNo: barNo);
        for noteNo in 0 ..< noteNoArray!.count {
            noteType = Float(getNoteType(barNo: barNo, noteNo: noteNo))!;
            noteTypeSum += 1.0 / noteType;
        }
    
        return (noteTypeSum == flatTimeTotal);
    }
    
}

