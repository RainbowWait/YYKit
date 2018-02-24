//
//  YYTextRubyController.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/9.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class YYTextRubyController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.frame = UIScreen.main.bounds
        self.automaticallyAdjustsScrollViewInsets = false
        let text = NSMutableAttributedString()
        let one = NSMutableAttributedString(string: "这是用汉语写的一段文字。")
        one.font = UIFont.boldSystemFont(ofSize: 30)
        var ruby = YYTextRubyAnnotation()
        ruby.textBefore = "hàn yŭ"
        one.setTextRubyAnnotation(ruby, range: (one.string as NSString).range(of: "汉语"))
        ruby = YYTextRubyAnnotation()
        ruby.textBefore = "wén"
        one.setTextRubyAnnotation(ruby, range: (one.string as NSString).range(of: "文"))
        ruby = YYTextRubyAnnotation()
        ruby.textBefore = "zì"
        one.setTextRubyAnnotation(ruby, range: (one.string as NSString).range(of: "字"))
        text.append(one)
//        text.append(padding())
        
        let label = YYLabel()
        label.attributedText = text
        label.width = self.view.width - 60
        label.centerX = self.view.width / 2
        label.height = self.view.height - 64 - 60
        label.top = 64 + 30
        label.textAlignment = .center
        label.textVerticalAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = UIColor(white: 0.933, alpha: 1.000)
        self.view.addSubview(label)
        
        
    }
    
    func padding() -> NSMutableAttributedString {
        let pad = NSMutableAttributedString(string: "\n\n")
        pad.font = UIFont.systemFont(ofSize: 30)
        return pad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
