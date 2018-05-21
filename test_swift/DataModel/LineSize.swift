//
//  LineSize.swift
//  test_swift
//
//  Created by 孔令文 on 2018/5/13.
//  Copyright © 2018年 孔令文. All rights reserved.
//

import Foundation
import UIKit

class LineSize: NSObject {
    
    private var _startBarNo: Int
    private var _barNum: Int
    private var _barWidthArray: [CGFloat]?
    private var _minimWidth: CGFloat
    private var _crotchetaWidth: CGFloat
    private var _quaverWidth: CGFloat
    private var _demiquaverWidth: CGFloat
    
    override init() {
        _startBarNo = 0
        _barNum = 0
        _barWidthArray = nil
        _minimWidth = 0
        _crotchetaWidth = 0
        _quaverWidth = 0
        _demiquaverWidth = 0
    }
    
    var startBarNo: Int {
        get {
            return _startBarNo
        }
        set {
            _startBarNo = newValue
        }
    }
    
    var barNum: Int {
        get {
            return _barNum
        }
        set {
            _barNum = newValue
        }
    }
    
    var barWidthArray: [CGFloat] {
        get {
            return _barWidthArray!
        }
        set {
            _barWidthArray = newValue
        }
    }
    
    var minimWidth: CGFloat {
        get {
            return _minimWidth
        }
        set {
            _minimWidth = newValue
        }
    }
    
    var crotchetaWidth: CGFloat {
        get {
            return _crotchetaWidth
        }
        set {
            _crotchetaWidth = newValue
        }
    }
    
    var quaverWidth: CGFloat {
        get {
            return _quaverWidth
        }
        set {
            _quaverWidth = newValue
        }
    }
    
    var demiquaverWidth: CGFloat {
        get {
            return _demiquaverWidth
        }
        set {
            _demiquaverWidth = newValue
        }
    }
    
    func getNoteWidth(noteType: String) -> CGFloat {
        switch noteType {
        case NotesModel.TYPE_MINIM:
            return _minimWidth
        case NotesModel.TYPE_CROTCHET:
            return _crotchetaWidth
        case NotesModel.TYPE_QUAVER:
            return _quaverWidth
        case NotesModel.TYPE_DEMIQUAVER:
            return _demiquaverWidth
        default:
            return 0
        }
    }
}
