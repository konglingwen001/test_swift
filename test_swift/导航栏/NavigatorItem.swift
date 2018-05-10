//
//  NavigatorItem.swift
//  test_swift
//
//  Created by 孔令文 on 2018/5/4.
//  Copyright © 2018年 孔令文. All rights reserved.
//

import UIKit

class NavigatorItem: UIView {

    @IBOutlet var btnItem: UIButton!
    @IBOutlet var lblItemName: UILabel!
    
    func setName(itemName:String) {
        self.lblItemName.text = itemName
    }
    
    func setSelected(selected:Bool) {
        if selected == true {
            self.lblItemName.textColor = UIColor.green
        } else {
            self.lblItemName.textColor = UIColor.init(red: 0xe6, green: 0xe6, blue: 0xe6, alpha: 200)
        }
    }
    
    func addTarget(target:Any, action:Selector) {
        self.btnItem.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
    }
    
    /*
     
     // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
