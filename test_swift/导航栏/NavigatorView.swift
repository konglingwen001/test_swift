//
//  NavigatorView.swift
//  test_swift
//
//  Created by 孔令文 on 2018/5/4.
//  Copyright © 2018年 孔令文. All rights reserved.
//

import UIKit

class NavigatorView: UIView {
    
    weak var delegate : NavigatorDelegate?
    
    var searchItem:NavigatorItem!
    var myMusicItem:NavigatorItem!
    var musicLibraryItem:NavigatorItem!
    var toolItem:NavigatorItem!
    var settingItem:NavigatorItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addNavigatorItems()
        setNavigatorItemConstraint()
        addTargets()
        musicLibraryItemClicked()
    }
    
    func addNavigatorItems() {
        searchItem = Bundle.main.loadNibNamed("NavigatorItem", owner: self, options: nil)?.last as! NavigatorItem;
        searchItem.setName(itemName: "搜索")
        searchItem.tag = 0
        searchItem.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchItem)
        
        myMusicItem = Bundle.main.loadNibNamed("NavigatorItem", owner: self, options: nil)?.last as! NavigatorItem;
        myMusicItem.setName(itemName: "我的")
        myMusicItem.tag = 0
        myMusicItem.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(myMusicItem)
        
        musicLibraryItem = Bundle.main.loadNibNamed("NavigatorItem", owner: self, options: nil)?.last as! NavigatorItem;
        musicLibraryItem.setName(itemName: "乐库")
        musicLibraryItem.tag = 0
        musicLibraryItem.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(musicLibraryItem)
        
        toolItem = Bundle.main.loadNibNamed("NavigatorItem", owner: self, options: nil)?.last as! NavigatorItem;
        toolItem.setName(itemName: "工具")
        toolItem.tag = 0
        toolItem.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(toolItem)
        
        settingItem = Bundle.main.loadNibNamed("NavigatorItem", owner: self, options: nil)?.last as! NavigatorItem;
        settingItem.setName(itemName: "设定")
        settingItem.tag = 0
        settingItem.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(settingItem)
    }
    
    func addTargets() {
        searchItem.addTarget(target: self, action: #selector(searchItemClicked))
        myMusicItem.addTarget(target: self, action: #selector(myMusicItemClicked))
        musicLibraryItem.addTarget(target: self, action: #selector(musicLibraryItemClicked))
        toolItem.addTarget(target: self, action: #selector(toolItemClicked))
        settingItem.addTarget(target: self, action: #selector(settingItemClicked))
    }
    
    @objc func searchItemClicked() {
        searchItem.setSelected(selected: true)
        myMusicItem.setSelected(selected: false)
        musicLibraryItem.setSelected(selected: false)
        toolItem.setSelected(selected: false)
        settingItem.setSelected(selected: false)
        
        self.delegate?.didSelected?(index: 0)
    }
    
    @objc func myMusicItemClicked() {
        searchItem.setSelected(selected: false)
        myMusicItem.setSelected(selected: true)
        musicLibraryItem.setSelected(selected: false)
        toolItem.setSelected(selected: false)
        settingItem.setSelected(selected: false)
        
        self.delegate?.didSelected?(index: 1)
    }
    
    @objc func musicLibraryItemClicked() {
        searchItem.setSelected(selected: false)
        myMusicItem.setSelected(selected: false)
        musicLibraryItem.setSelected(selected: true)
        toolItem.setSelected(selected: false)
        settingItem.setSelected(selected: false)
        
        self.delegate?.didSelected?(index: 2)
    }
    
    @objc func toolItemClicked() {
        searchItem.setSelected(selected: false)
        myMusicItem.setSelected(selected: false)
        musicLibraryItem.setSelected(selected: false)
        toolItem.setSelected(selected: true)
        settingItem.setSelected(selected: false)
        
        self.delegate?.didSelected?(index: 3)
    }
    
    @objc func settingItemClicked() {
        searchItem.setSelected(selected: false)
        myMusicItem.setSelected(selected: false)
        musicLibraryItem.setSelected(selected: false)
        toolItem.setSelected(selected: false)
        settingItem.setSelected(selected: true)
        
        self.delegate?.didSelected?(index: 4)
    }
    
    func setNavigatorItemConstraint() {
    
        // 播放控制器约束添加
        let searchItemLeft : NSLayoutConstraint = NSLayoutConstraint(item: searchItem, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 10)
        let searchItemVerticalCenter : NSLayoutConstraint = NSLayoutConstraint(item: searchItem, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let searchItemWidth : NSLayoutConstraint = NSLayoutConstraint(item: searchItem, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 50)
        let searchItemHeight : NSLayoutConstraint = NSLayoutConstraint(item: searchItem, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60)
        searchItem.addConstraint(searchItemWidth)
        searchItem.addConstraint(searchItemHeight)
        
        let myMusicItemRight : NSLayoutConstraint = NSLayoutConstraint(item: myMusicItem, attribute: .trailing, relatedBy: .equal, toItem: musicLibraryItem, attribute: .leading, multiplier: 1, constant: -20)
        let myMusicItemVerticalCenter : NSLayoutConstraint = NSLayoutConstraint(item: myMusicItem, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let myMusicItemWidth : NSLayoutConstraint = NSLayoutConstraint(item: myMusicItem, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 50)
        let myMusicItemHeight : NSLayoutConstraint = NSLayoutConstraint(item: myMusicItem, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60)
        myMusicItem.addConstraint(myMusicItemWidth)
        myMusicItem.addConstraint(myMusicItemHeight)
        
        let musicLibraryItemHosizontalCenter : NSLayoutConstraint = NSLayoutConstraint(item: musicLibraryItem, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let musicLibraryItemVerticalCenter : NSLayoutConstraint = NSLayoutConstraint(item: musicLibraryItem, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let musicLibraryItemWidth : NSLayoutConstraint = NSLayoutConstraint(item: musicLibraryItem, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 50)
        let musicLibraryItemHeight : NSLayoutConstraint = NSLayoutConstraint(item: musicLibraryItem, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60)
        musicLibraryItem.addConstraint(musicLibraryItemWidth)
        musicLibraryItem.addConstraint(musicLibraryItemHeight)
        
        let toolItemLeft : NSLayoutConstraint = NSLayoutConstraint(item: toolItem, attribute: .leading, relatedBy: .equal, toItem: musicLibraryItem, attribute: .trailing, multiplier: 1, constant: 20)
        let toolItemVerticalCenter : NSLayoutConstraint = NSLayoutConstraint(item: toolItem, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let toolItemWidth : NSLayoutConstraint = NSLayoutConstraint(item: toolItem, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 50)
        let toolItemHeight : NSLayoutConstraint = NSLayoutConstraint(item: toolItem, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60)
        toolItem.addConstraint(toolItemWidth)
        toolItem.addConstraint(toolItemHeight)
        
        let settingItemRight : NSLayoutConstraint = NSLayoutConstraint(item: settingItem, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -10)
        let settingItemVerticalCenter : NSLayoutConstraint = NSLayoutConstraint(item: settingItem, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let settingItemWidth : NSLayoutConstraint = NSLayoutConstraint(item: settingItem, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 50)
        let settingItemHeight : NSLayoutConstraint = NSLayoutConstraint(item: settingItem, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60)
        settingItem.addConstraint(settingItemWidth)
        settingItem.addConstraint(settingItemHeight)
    
        let constraints = [searchItemLeft, searchItemVerticalCenter, myMusicItemRight, myMusicItemVerticalCenter, musicLibraryItemVerticalCenter, musicLibraryItemHosizontalCenter, toolItemLeft, toolItemVerticalCenter, settingItemRight, settingItemVerticalCenter];
        self.addConstraints(constraints)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
