//
//  DictDataUtil.swift
//  test_swift
//
//  Created by 孔令文 on 2018/5/13.
//  Copyright © 2018年 孔令文. All rights reserved.
//

import Foundation

class DictDataUtil: NSObject {
    override init() {}
    
    static func getGuitarNotesTitle(noteNoData: NSMutableDictionary) -> String {
        return noteNoData.value(forKey: "GuitarNotesName") as! String
    }
    
    static func setGuitarNotesTitle(noteNoData: NSMutableDictionary, noteType: String) {
        noteNoData.setValue(noteType, forKey: "GuitarNotesName")
    }
    
    static func getFlat(noteNoData: NSMutableDictionary) -> String {
        return noteNoData.value(forKey: "Flat") as! String
    }
    
    static func setFlat(noteNoData: NSMutableDictionary, noteType: String) {
        noteNoData.setValue(noteType, forKey: "Flat")
    }
    
    static func getSpeed(noteNoData: NSMutableDictionary) -> String {
        return noteNoData.value(forKey: "Speed") as! String
    }
    
    static func setSpeed(noteNoData: NSMutableDictionary, noteType: String) {
        noteNoData.setValue(noteType, forKey: "Speed")
    }
    
    static func getBarBum(noteNoData: NSMutableDictionary) -> String {
        return noteNoData.value(forKey: "BarNum") as! String
    }
    
    static func setBarNum(noteNoData: NSMutableDictionary, noteType: String) {
        noteNoData.setValue(noteType, forKey: "BarNum")
    }
    
    static func getNoteType(noteNoData: NSMutableDictionary) -> String {
        return noteNoData.value(forKey: "NoteType") as! String
    }
    
    static func setNoteType(noteNoData: NSMutableDictionary, noteType: String) {
        noteNoData.setValue(noteType, forKey: "NoteType")
    }
    
    static func getNotesArray(noteNoData: NSMutableDictionary) -> NSMutableArray {
        return noteNoData.value(forKey: "noteArray") as! NSMutableArray
    }
    
    static func setNotesArray(noteNoData: NSMutableDictionary, notesArray: NSMutableArray) {
        noteNoData.setValue(notesArray, forKey: "noteArray")
    }
    
    static func getStringNo(note: NSMutableDictionary) -> Int {
        return note.value(forKey: "StringNo") as! Int
    }
    
    static func setStringNo(note: NSMutableDictionary, stringNo: Int) {
        note.setValue(stringNo, forKey: "StringNo")
    }
    
    static func getFretNo(note: NSMutableDictionary) -> Int {
        return note.value(forKey: "FretNo") as! Int
    }
    
    static func setFretNo(note: NSMutableDictionary, fretNo: Int) {
        note.setValue(fretNo, forKey: "FretNo")
    }
    
    static func getPlayType(note: NSMutableDictionary) -> String {
        return note.value(forKey: "PlayType") as! String
    }
    
    static func setPlayType(note: NSMutableDictionary, playType: String) {
        note.setValue(playType, forKey: "PlayType")
    }
    
}
