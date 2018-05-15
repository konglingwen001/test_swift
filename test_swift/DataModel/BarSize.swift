//
//  BarSize.swift
//  test_swift
//
//  Created by 孔令文 on 2018/5/13.
//  Copyright © 2018年 孔令文. All rights reserved.
//

import Foundation

class BarSize: NSObject {
    
    private var _barWidth: Float
    private var _minimNum: Int
    private var _crotchetaNum: Int
    private var _quaverNum: Int
    private var _demiquaverNum: Int
    
    override init() {
        _barWidth = 0
        _minimNum = 0
        _crotchetaNum = 0
        _quaverNum = 0
        _demiquaverNum = 0
    }
    
    var barWidth: Float {
        get {
            return _barWidth
        }
        set {
            _barWidth = newValue
        }
    }
    
    var minimNum: Int {
        get {
            return _minimNum
        }
        set {
            _minimNum = newValue
        }
    }
    
    var crotchetaNum: Int {
        get {
            return _crotchetaNum
        }
        set {
            _crotchetaNum = newValue
        }
    }
    
    var quaverNum: Int {
        get {
            return _quaverNum
        }
        set {
            _quaverNum = newValue
        }
    }
    
    var demiquaverNum: Int {
        get {
            return _demiquaverNum
        }
        set {
            _demiquaverNum = newValue
        }
    }
}
