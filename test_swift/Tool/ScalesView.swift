//
//  ScalesView.swift
//  test_swift
//
//  Created by 孔令文 on 2018/7/28.
//  Copyright © 2018年 孔令文. All rights reserved.
//

import UIKit

class ScalesView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        drawScales()
    }
    
    func drawScales() {
        let context = UIGraphicsGetCurrentContext()
        context!.setLineWidth(2)
        context!.setFillColor(UIColor.black.cgColor)
        
        let width = self.frame.width
        let height = self.frame.height
        let intervalNum:CGFloat = 50
        let startInterval:CGFloat = 20.0
        let interval = (width - startInterval * 2.0) / intervalNum
        
        var x:Int
        var offsetY:Int
        for i in 0...50 {
            x = Int(startInterval + interval * CGFloat(i))
            if (i % 5 == 0) {
                offsetY = 10
            } else {
                offsetY = 0
            }
            context!.move(to: CGPoint(x: x, y: Int(height - 20)))
            context!.addLine(to: CGPoint(x: x, y: Int(Int(height) - 30 - offsetY)))
        }
        context!.strokePath()
        
    }
 

}
