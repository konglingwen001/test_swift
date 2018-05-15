//
//  EditNoteInfo.swift
//  test_swift
//
//  Created by 孔令文 on 2018/5/13.
//  Copyright © 2018年 孔令文. All rights reserved.
//

import Foundation

class EditNoteInfo {
    private var _barNo: Int
    private var _noteNo: Int
    private var _stringNo: Int
    
    var barNo: Int {
        get {
            return _barNo
        }
        set {
            _barNo = newValue
        }
    }
    
    var noteNo: Int {
        get {
            return _noteNo
        }
        set {
            _noteNo = newValue
        }
    }
    
    var stringNo: Int {
        get {
            return _stringNo
        }
        set {
            _stringNo = newValue
        }
    }
    
    init() {
        _barNo = 0
        _noteNo = 0
        _stringNo = 0
    }
    
    init(barNo: Int, noteNo: Int, stringNo: Int) {
        _barNo = barNo
        _noteNo = noteNo
        _stringNo = stringNo
    }
    
    
}
