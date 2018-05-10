//
//  ViewController.swift
//  test_swift
//
//  Created by 孔令文 on 2018/5/4.
//  Copyright © 2018年 孔令文. All rights reserved.
//

import UIKit

class ViewController: UITabBarController, NavigatorDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myTabBar:NavigatorTabBar = NavigatorTabBar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        myTabBar.tabBarView.delegate = self;
        self.setValue(myTabBar, forKey: "tabBar")
        
        let searchViewController = SearchViewController()
        let myZoneViewController = MyZoneViewController()
        let musicLibraryViewController = MusicLibraryViewController()
        let toolViewController = ToolViewController()
        let settingViewController = SettingViewController()
        
        self.addChildViewController(searchViewController)
        self.addChildViewController(myZoneViewController)
        self.addChildViewController(musicLibraryViewController)
        self.addChildViewController(toolViewController)
        self.addChildViewController(settingViewController)
        
        self.selectedIndex = 2;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didSelected(index:Int) {
        self.selectedIndex = index
    }


}

