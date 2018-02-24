//
//  YYTextExampleHelper.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/12.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class YYTextExampleHelper: NSObject {
  public static var DebugEnabled = false

   public class func addDebugOptionToViewController(vc: UIViewController) {
        let switcher = UISwitch()
        switcher.layer.transformScale = 0.8
        switcher.setOn(DebugEnabled, animated: true)
    switcher.addBlock(for: .valueChanged) { (sender) in
        self.setDebug(debug: (sender as! UISwitch).isOn)
        }
    
    let view = UIView()
    view.size = CGSize(width: 40, height: 44)
    view.addSubview(switcher)
    switcher.centerX = view.width / 2
    switcher.centerY = view.height / 2
    let item = UIBarButtonItem(customView: view)
    vc.navigationItem.rightBarButtonItem = item
    
    
    
        
        
    }
    
    public class func setDebug(debug: Bool) {
        let debugOptions = YYTextDebugOption()
        if debug {
            debugOptions.baselineColor = UIColor.red
            debugOptions.ctFrameBorderColor = UIColor.red
            debugOptions.ctLineFillColor = UIColor(red: 0.000, green: 0.463, blue: 1.000, alpha: 0.180)
            debugOptions.cgGlyphBorderColor = UIColor(red: 1.000, green: 0.524, blue: 0.000, alpha: 0.200)
        } else {
            debugOptions.clear()
        }
        YYTextDebugOption.setShared(debugOptions)
        DebugEnabled = debug
        
    }
}
