//
//  NavigatorDelegate.swift
//  test_swift
//
//  Created by 孔令文 on 2018/5/10.
//  Copyright © 2018年 孔令文. All rights reserved.
//

import Foundation

@objc protocol NavigatorDelegate : NSObjectProtocol {
    @objc optional func didSelected(index:Int);
}
