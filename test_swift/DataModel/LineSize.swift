//
//  LineSize.swift
//  test_swift
//
//  Created by 孔令文 on 2018/5/13.
//  Copyright © 2018年 孔令文. All rights reserved.
//

import Foundation

class LineSize: NSObject {
    
    private var _startBarNo: Int
    private var _barNum: Int
    private var _barWidthArray: NSMutableArray?
    private var _minimWidth: Float
    private var _crotchetaWidth: Float
    private var _quaverWidth: Float
    private var _demiquaverWidth: Float
    
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
    
    var barWidthArray: NSMutableArray {
        get {
            return _barWidthArray!
        }
        set {
            _barWidthArray = newValue
        }
    }
    
    var minimWidth: Float {
        get {
            return _minimWidth
        }
        set {
            _minimWidth = newValue
        }
    }
    
    var crotchetaWidth: Float {
        get {
            return _crotchetaWidth
        }
        set {
            _crotchetaWidth = newValue
        }
    }
    
    var quaverWidth: Float {
        get {
            return _quaverWidth
        }
        set {
            _quaverWidth = newValue
        }
    }
    
    var demiquaverWidth: Float {
        get {
            return _demiquaverWidth
        }
        set {
            _demiquaverWidth = newValue
        }
    }
}
