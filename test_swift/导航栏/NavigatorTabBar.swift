//
//  NavigatorTabBar.swift
//  test_swift
//
//  Created by 孔令文 on 2018/5/4.
//  Copyright © 2018年 孔令文. All rights reserved.
//

import UIKit

class NavigatorTabBar: UITabBar {
    
    var navigatorViewName:String
    
    lazy var tabBarView: NavigatorView = {
        let tmpTabBarView : NavigatorView = Bundle.main.loadNibNamed(navigatorViewName, owner: self, options: nil)?.last as! NavigatorView
        return tmpTabBarView
    }()
    
    override init(frame: CGRect) {
        navigatorViewName = "NavigatorView"
        super.init(frame: frame)
        
        self.addSubview(tabBarView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        var frame:CGRect = self.frame
        frame.origin.y = 20
        frame.size.height = 50
        self.frame = frame
        
        self.tabBarView.frame = self.bounds
        self.bringSubview(toFront: self.tabBarView)
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
