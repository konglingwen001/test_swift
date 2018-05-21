//
//  GuitarNoteTableViewCell.swift
//  test_swift
//
//  Created by 孔令文 on 2018/5/19.
//  Copyright © 2018年 孔令文. All rights reserved.
//

import UIKit

class GuitarNoteTableViewCell: UITableViewCell {
    
    var notesModel: NotesModel? = nil
    var delegate: NoteTableViewDelegate? = nil
    var lineNo: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        notesModel = NotesModel.getInstance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        notesModel = NotesModel.getInstance()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context!.setStrokeColor(UIColor.black.cgColor)
        
        //context!.setLineWidth(1)
        NSLog("line \(lineNo) refreshed")
        drawNoteLine(context: context!, lineNo: lineNo)
        drawNotes(context: context!, lineNo: lineNo)
        drawStem(context: context!, lineNo: lineNo)
        
        context!.strokePath()
    }
    
    func drawNoteLine(context: CGContext, lineNo: Int) {
    
        let width = UIScreen.main.bounds.width
        let lineStart = notesModel!.getLineWidth()
        let lineEnd = width - notesModel!.getLineWidth();
        let barStartY = notesModel!.getLineWidth();
        let offsetY = notesModel!.getLineWidth();
        let points_stringLine: [CGPoint] = [CGPoint(x: lineStart, y: barStartY), CGPoint(x: lineEnd, y: barStartY),
        CGPoint(x: lineStart, y: barStartY + offsetY), CGPoint(x: lineEnd, y: barStartY + offsetY),
        CGPoint(x: lineStart, y: barStartY + offsetY * 2), CGPoint(x: lineEnd, y: barStartY + offsetY * 2),
        CGPoint(x: lineStart, y: barStartY + offsetY * 3), CGPoint(x: lineEnd, y: barStartY + offsetY * 3),
        CGPoint(x: lineStart, y: barStartY + offsetY * 4), CGPoint(x: lineEnd, y: barStartY + offsetY * 4),
        CGPoint(x: lineStart, y: barStartY + offsetY * 5), CGPoint(x: lineEnd, y: barStartY + offsetY * 5)];
        
        context.setLineWidth(1)
        context.strokeLineSegments(between: points_stringLine)
        
        var barLineX: CGFloat = 0;
        let barWidthArray: [CGFloat] = notesModel!.getBarWidthArray(lineNo: lineNo)
        var points_barLine: [CGPoint] = []
        for i in 0 ..< barWidthArray.count {
            barLineX = barWidthArray[i] + notesModel!.getLineWidth();
            points_barLine.append(CGPoint(x: barLineX, y: barStartY))
            points_barLine.append(CGPoint(x: barLineX, y: barStartY + offsetY * 5))
        }
        context.setLineWidth(2)
        context.strokeLineSegments(between: points_barLine)
    }
    
    func drawNotes(context: CGContext, lineNo: Int) {
        let editNote = notesModel!.getCurrEditNote()
        let editBarNo = editNote.barNo
        let editNoteNo = editNote.noteNo
        let editStringNo = editNote.stringNo
    
        let barStartX = notesModel!.getLineWidth();
        let barStartY = notesModel!.getLineWidth();
        let offsetY = notesModel!.getLineWidth();
    
        //context.setFontSiz(notesModel!.getNoteSize()); //提前设置字体，用于绘制音符时计算字体大小
    
        let lineSizeArray = notesModel!.getNotesSizeArray();
        let lineSize: LineSize = lineSizeArray[lineNo] as! LineSize
        let lineBarNum = lineSize.barNum
        var barWidthArray = lineSize.barWidthArray
    
        // 绘制吉他音符
        let startBarNo: Int = lineSize.startBarNo
        var noteCenterX: CGFloat = 0, noteCenterY: CGFloat = 0; // 音符中心坐标
        var noteColor: UIColor;
        for barNo in startBarNo ..< startBarNo + lineBarNum {
    
            noteColor = notesModel!.checkBarStateAtBarNo(barNo: barNo) ? UIColor.black : UIColor.red;
    
            // 小节开始X坐标设置
            noteCenterX = barStartX + barWidthArray[barNo - startBarNo]
    
            let noteNoArray = notesModel!.getNoteNoDataArray(barNo: barNo)
            for noteNo in 0 ..< noteNoArray.count {
                let notes = DictDataUtil.getNotesArray(noteNoData: noteNoArray[noteNo] as! NSMutableDictionary)
                let noteType = notesModel!.getNoteType(barNo: barNo, noteNo: noteNo)
            
                // 设定音符X坐标
                noteCenterX += lineSize.getNoteWidth(noteType: noteType)
            
                // 根据触摸位置所在的音符位置绘制音符编辑框
                if (barNo == editBarNo && noteNo == editNoteNo) {
                    context.setFillColor(UIColor.green.cgColor)
                    noteCenterY = barStartY + CGFloat(editStringNo - 1) * offsetY + 0.5;
                    context.fill(CGRect(x: noteCenterX - notesModel!.getNoteSize() / 2, y: noteCenterY - notesModel!.getNoteSize() / 2, width: notesModel!.getNoteSize(), height: notesModel!.getNoteSize()))
                }
            
                for i in 0 ..< notes.count {
            
                    let note: NSMutableDictionary? = notes[i] as? NSMutableDictionary
                    let stringNo = DictDataUtil.getStringNo(note: note!)
                
                    let fretNo: NSString = String(DictDataUtil.getFretNo(note: note!)) as NSString
                    let attr = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12.0)]
                    let fretNoSize: CGSize = fretNo.size(withAttributes: attr)
                
                    noteCenterY = barStartY + CGFloat(stringNo - 1) * offsetY + 0.5;
                
                    // 没有被选中的音符绘制白色背景，避免横线贯穿音符
                    if (!(barNo == editBarNo && noteNo == editNoteNo && stringNo == editStringNo)) {
                        context.setFillColor(UIColor.white.cgColor)
                        context.fill(CGRect(x: noteCenterX - fretNoSize.width / 2, y: noteCenterY - fretNoSize.height / 2, width: fretNoSize.width, height: fretNoSize.height))
                    }
                
                    // 绘制音符(音符为空时不绘制)
                    if (stringNo != -1 && fretNo != "-1") {
                        context.setStrokeColor(noteColor.cgColor)
                        let attr = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12.0)]
                        (fretNo as NSString).draw(at: CGPoint(x: noteCenterX - fretNoSize.width / 2, y: noteCenterY - fretNoSize.height / 2), withAttributes: attr)
                    }
    
                }
            }
        }
    }
    
    func drawStem(context: CGContext, lineNo: Int) {
    
        let myFlatTime: Float = notesModel!.getFlatTime();
        
        let height = self.bounds.height
        let lineSizeArray = notesModel!.getNotesSizeArray();
        let lineSize: LineSize = lineSizeArray[lineNo] as! LineSize;
        let lineBarNum = lineSize.barNum
        let barWidthArr = lineSize.barWidthArray
        
        // 绘制符干
        let startBarNo = lineSize.startBarNo
        let barStartX: CGFloat = notesModel!.getNoteSize()
        var noteCenterX: CGFloat = 0; // 音符中心坐标
        var stemColor: UIColor
        for barNo in startBarNo ..< startBarNo + lineBarNum {
        
            stemColor = notesModel!.checkBarStateAtBarNo(barNo: barNo) ? UIColor.black : UIColor.red
            context.setStrokeColor(stemColor.cgColor)
            
            // 小节开始X坐标设置
            noteCenterX = barStartX + CGFloat(barWidthArr[barNo - startBarNo]);
            
            var currentNoteWidth: CGFloat = 0;
            var flatSum: Float = 0;
            var preNoteType: String = "";
            let noteNoArray = notesModel!.getNoteNoDataArray(barNo: barNo);
            for noteNo in 0 ..< noteNoArray.count {
                let noteType = notesModel!.getNoteType(barNo: barNo, noteNo: noteNo)
                
                context.setLineWidth(2)
                // 设定符干X坐标
                switch (noteType) {
                case NotesModel.TYPE_MINIM:
                    if (preNoteType == NotesModel.TYPE_QUAVER) {
                        // 前一个音符为八分音符
                        // 绘制符干连接线
                        context.strokeLineSegments(between: [CGPoint(x: noteCenterX, y: height - notesModel!.getLineWidth()), CGPoint(x: noteCenterX + notesModel!.getNoteSize(), y: height - notesModel!.getLineWidth())])
                    } else if (preNoteType == NotesModel.TYPE_DEMIQUAVER) {
                        // 前一个音符为十六分音符
                        // 绘制符干连接线
                        context.strokeLineSegments(between: [CGPoint(x: noteCenterX, y: height - notesModel!.getLineWidth()), CGPoint(x: noteCenterX + notesModel!.getNoteSize(), y: height - notesModel!.getLineWidth())])
                        context.strokeLineSegments(between: [CGPoint(x: noteCenterX, y: height - notesModel!.getLineWidth() * 1.5), CGPoint(x: noteCenterX + notesModel!.getNoteSize(), y: height - notesModel!.getLineWidth() * 1.5)])
                    }
                    flatSum += 0.5;
                    noteCenterX += lineSize.minimWidth
                case NotesModel.TYPE_CROTCHET:
                    if (preNoteType == NotesModel.TYPE_QUAVER) {
                        // 前一个音符为八分音符
                        // 绘制符干连接线
                        context.strokeLineSegments(between: [CGPoint(x: noteCenterX, y: height - notesModel!.getLineWidth()), CGPoint(x: noteCenterX + notesModel!.getNoteSize(), y: height - notesModel!.getLineWidth())])
                    } else if (preNoteType == NotesModel.TYPE_DEMIQUAVER) {
                        // 前一个音符为十六分音符
                        // 绘制符干连接线
                        context.strokeLineSegments(between: [CGPoint(x: noteCenterX, y: height - notesModel!.getLineWidth()), CGPoint(x: noteCenterX + notesModel!.getNoteSize(), y: height - notesModel!.getLineWidth())])
                        context.strokeLineSegments(between: [CGPoint(x: noteCenterX, y: height - notesModel!.getLineWidth() * 1.5), CGPoint(x: noteCenterX + notesModel!.getNoteSize(), y: height - notesModel!.getLineWidth() * 1.5)])
                    }
                    flatSum += 0.25
                    noteCenterX += lineSize.crotchetaWidth
                case NotesModel.TYPE_QUAVER:
                    flatSum += 0.125;
                    currentNoteWidth = lineSize.quaverWidth
                    noteCenterX += currentNoteWidth;
                    
                    if (flatSum <= myFlatTime) {
                        // 判断前一个音符种类
                        if (preNoteType == "") {
                            // 当前音符为音符的开始音符，保存
                            preNoteType = noteType;
                        } else {
                            if (preNoteType == NotesModel.TYPE_QUAVER || preNoteType == NotesModel.TYPE_DEMIQUAVER) {
                                // 前一个音符为八分音符
                                // 绘制符干连接线
                                context.strokeLineSegments(between: [CGPoint(x: noteCenterX, y: height - notesModel!.getLineWidth()), CGPoint(x: noteCenterX - currentNoteWidth, y: height - notesModel!.getLineWidth())])
                            }
                        }
                    }
                case NotesModel.TYPE_DEMIQUAVER:
                    flatSum += 0.0625;
                    currentNoteWidth = lineSize.demiquaverWidth
                    noteCenterX += currentNoteWidth;
                    
                    if (flatSum <= myFlatTime) {
                        // 判断前一个音符种类
                        if (preNoteType == "") {
                            // 当前音符为音符的开始音符，保存
                            preNoteType = noteType;
                        } else {
                            if (preNoteType == NotesModel.TYPE_QUAVER) {
                                // 前一个音符为八分音符
                                // 绘制符干连接线
                                context.strokeLineSegments(between: [CGPoint(x: noteCenterX, y: height - notesModel!.getLineWidth()), CGPoint(x: noteCenterX - currentNoteWidth, y: height - notesModel!.getLineWidth())])
                            } else if (preNoteType == NotesModel.TYPE_DEMIQUAVER) {
                                context.strokeLineSegments(between: [CGPoint(x: noteCenterX, y: height - notesModel!.getLineWidth()), CGPoint(x: noteCenterX - currentNoteWidth, y: height - notesModel!.getLineWidth())])
                                context.strokeLineSegments(between: [CGPoint(x: noteCenterX, y: height - notesModel!.getLineWidth() * 1.5), CGPoint(x: noteCenterX - currentNoteWidth, y: height - notesModel!.getLineWidth() * 1.5)])
                            }
                        }
                    }
                default:
                    NSLog("doNothing")
                }
        
                // 绘制符干
                context.setLineWidth(1)
                context.strokeLineSegments(between: [CGPoint(x: noteCenterX, y: height - notesModel!.getLineWidth() * 3), CGPoint(x: noteCenterX, y: height - notesModel!.getLineWidth())])
                
                preNoteType = noteType;
                if (flatSum == myFlatTime) {
                    flatSum = 0;
                    preNoteType = "";
                }
            }
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 获取触摸点在当前cell中的坐标
        let touch: UITouch = touches.first!
        let point: CGPoint = touch.location(in: touch.view)
        
        var oldLineNo: Int = 0
        let note: EditNoteInfo = notesModel!.getCurrEditNote()
        let notesSizeArray = notesModel!.getNotesSizeArray()
        for i in 0 ..< notesSizeArray.count {
            let lineSize: LineSize = notesSizeArray[i] as! LineSize
            if note.barNo >= lineSize.startBarNo && note.barNo < lineSize.startBarNo + lineSize.barNum {
                oldLineNo = i
                break;
            }
        }
        
        // 计算触摸点所在的音符位置
        let result = calRectFromPoint(point: point)
        
        // 刷新吉他谱
        if (result == true) {
            if (lineNo != oldLineNo) {
                self.delegate!.refreshRow(row: oldLineNo)
            }
            self.delegate!.refreshRow(row: lineNo)
            
        }
        NSLog("---------------------")
    }
    
    func isOutsideOfGuitarNotes(point: CGPoint) -> Bool {
    
        // 判断X坐标是否在吉他谱内
        if (point.x < NotesModel.LINE_START_X || point.x > UIScreen.main.bounds.size.width - NotesModel.LINE_START_X) {
            return true
        }
        
        // 判断Y坐标是否在吉他谱内
        if (point.y < NotesModel.NOTE_SIZE / 2) {
            return true
        } else if (NotesModel.LINE_START_Y + NotesModel.NOTE_SIZE * 5 + NotesModel.NOTE_SIZE / 2 < point.y) {
            return true
        }
        
        return false
    }
    
    /*!
     * @brief 计算触摸位置所在的音符位置
     * @discussion 根据触摸位置坐标计算所在的音符位置，当当前编辑音符位置改变时，返回YES并刷新吉他谱，否则返回NO，不刷新吉他谱
     * @param point 触摸位置坐标
     * @return YES 触摸位置在吉他谱内，刷新吉他谱
     * @return NO 触摸位置不在吉他谱内，不用刷新吉他谱
     */
    func calRectFromPoint(point: CGPoint) -> Bool {
    
        let resultNote: EditNoteInfo = EditNoteInfo()
    
        var barStartX = NotesModel.LINE_START_X     // 小节行起始X坐标
        let barStartY = NotesModel.LINE_START_Y     // 小节行起始Y坐标
    
        // 当点击位置在吉他谱外面时，不改变编辑框位置
        if (isOutsideOfGuitarNotes(point: point)) {
            return false
        }
    
        let lineSize: LineSize = notesModel!.getLineSize(lineNo: lineNo)!
        var barNo: Int = lineSize.startBarNo
    
        let barWidthArray = lineSize.barWidthArray
    
        // 判断触摸位置所属的小节，i从1开始，因为barWidthArray[0] == 0
        for i in 1 ..< barWidthArray.count {
            let width: CGFloat = barWidthArray[i]
            if (point.x > barStartX + width) {
                barNo += 1
                barStartX += width
            } else {
                break
            }
        }
    
        let stringNo = (Int)((point.y - barStartY + NotesModel.NOTE_SIZE / 2) / NotesModel.NOTE_SIZE) + 1
        resultNote.stringNo = stringNo
        var addPosX = barStartX
        var currentWidth: CGFloat = 0
    
        let noteNoArray = notesModel!.getNoteNoDataArray(barNo: barNo)
        for noteNo in 0 ..< noteNoArray.count {
            let noteType = notesModel!.getNoteType(barNo: barNo, noteNo: noteNo)
    
            currentWidth = lineSize.getNoteWidth(noteType: noteType)
            addPosX += currentWidth
    
            if (point.x < addPosX) {
                if (noteNo == 0) {
                    resultNote.barNo = barNo
                    resultNote.noteNo = noteNo
                } else if (point.x > addPosX - currentWidth / 2) {
                    resultNote.barNo = barNo
                    resultNote.noteNo = noteNo
                } else {
                    resultNote.barNo = barNo
                    resultNote.noteNo = noteNo - 1
                }
                break;
                } else {
                    if (noteNo == noteNoArray.count - 1) {
                        resultNote.barNo = barNo
                        resultNote.noteNo = noteNo
                        break;
                    }
                }
    
        }
    
        // 当音符编辑框位置没有改变时，不刷新吉他谱
        if (resultNote.isEqualTo(editNote: notesModel!.getCurrEditNote())) {
            return false;
        }
    
        // 更新音符编辑框位置，并刷新吉他谱
        notesModel!.currEditNote = resultNote
        return true;
    }
    
    
}
