//
//  YYTextAttribute.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/9.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class YYTextAttribute: UIViewController {
    
    var label: YYLabel!
    var text: NSMutableAttributedString!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 0.933, alpha: 1.0)
        self.view.frame = UIScreen.main.bounds
        text = NSMutableAttributedString()
        addAttributed()
        label = YYLabel()
        label.attributedText = text
        label.width = self.view.width
        label.height = self.view.height - 74
        label.top = 74
        label.textAlignment = .center
        label.textVerticalAlignment = .center
        label.backgroundColor = UIColor(white: 0.933, alpha: 1.0)
        label.numberOfLines = 0
        self.view.addSubview(label)
        
        
        
    }
    func addAttributed() {
        
        //textShadow
        let one: NSMutableAttributedString = NSMutableAttributedString(string: "Shadow")
        one.font = UIFont.boldSystemFont(ofSize: 30)
        one.color = UIColor.white
        let textShadow = YYTextShadow(color: UIColor(white: 0.00, alpha: 0.49), offset: CGSize(width: 0, height: 0), radius: 5)
        one.textShadow = textShadow
        text.append(one)
        text.append(self.padding())
        
        //innerShadow
        let two = NSMutableAttributedString(string: "Inner Shadow")
        two.font = UIFont.boldSystemFont(ofSize: 30)
        two.color = UIColor.white
        let innderShadow = YYTextShadow(color: UIColor(white: 0.0, alpha: 0.40), offset: CGSize.zero, radius: 1)
        two.textInnerShadow = innderShadow
        text.append(two)
        text.append(padding())
        
        //Multiple Shadows
        let three = NSMutableAttributedString(string: "Multiple Shadows")
        three.font = UIFont.boldSystemFont(ofSize: 30)
        three.color = UIColor(red: 1.000, green: 0.795, blue: 0.014, alpha: 1.000)
        let textShadow1 = YYTextShadow(color: UIColor(white: 0.000, alpha: 0.20), offset: CGSize(width: 0, height: -1), radius: 1.5)
        let subShadow = YYTextShadow(color: UIColor(white: 1, alpha: 0.99), offset: CGSize(width: 0, height: 1), radius: 1.5)
        textShadow1.sub = subShadow
        three.textShadow = textShadow1
        
        let innerShadow1 = YYTextShadow(color: UIColor(red: 0.851, green: 0.311, blue: 0.000, alpha: 0.780), offset: CGSize(width: 0, height: 1), radius: 1)
        three.textInnerShadow = innerShadow1
        text.append(three)
        text.append(self.padding())
        
        //Background Image
        let four = NSMutableAttributedString(string: "Background Image")
        four.font = UIFont.boldSystemFont(ofSize: 30)
        four.backgroundColor = UIColor(red: 1.000, green: 0.795, blue: 0.014, alpha: 1.000)
        let size = CGSize(width: 20, height: 20)
        let background = UIImage(size: size) { (context) in
            let c0 = UIColor(red: 0.054, green: 0.879, blue: 0.000, alpha: 1.000)
            let c1 = UIColor(red: 0.869, green: 1.000, blue: 0.030, alpha: 1.000)
            c0.setFill()
            context.fill(CGRect(x: 0, y: 0, width: size.width , height: size.height))
            c1.setStroke()
            context.setLineWidth(2)
            var i = 0
            
            while (i < Int(size.width * 2)) {
                context.move(to: CGPoint(x: i, y: -2))
                context.addLine(to: CGPoint(x: CGFloat(i) - size.height, y: size.height + 2))
                i += 4
            }
            context.strokePath()
        }
        four.color = UIColor(patternImage: background!)
        text.append(four)
        text.append(self.padding())
        
        
        let five = NSMutableAttributedString(string: "Border")
        five.font = UIFont.boldSystemFont(ofSize: 20)
        five.color = UIColor(red: 1.000, green: 0.029, blue: 0.651, alpha: 1.000)
        let border = YYTextBorder(lineStyle: .single, lineWidth: 1, stroke: UIColor.black)
        border.cornerRadius = 10
        border.insets = UIEdgeInsets(top: -1, left: -5, bottom: -3, right: -5)
        five.textBackgroundBorder = border
        text.append(five)
        text.append(padding())
        
        //Link
        let six = NSMutableAttributedString(string: "Link")
        six.font = UIFont.boldSystemFont(ofSize: 30)
        six.underlineColor = UIColor.red
        six.underlineStyle = .styleSingle
        six.setTextHighlight(six.rangeOfAll(), color: UIColor.red, backgroundColor: UIColor.brown) { (containerView, text, range, rect) in
        }
        text.append(padding())
        text.append(padding())
        text.append(six)
        text.append(padding())
        
        //Another Link
        let seven = NSMutableAttributedString(string: "Another Link")
        seven.font = UIFont.systemFont(ofSize: 20)
        let borderSeven = YYTextBorder(lineStyle: .single, lineWidth: 0.5, stroke: UIColor.red)
        borderSeven.cornerRadius = 50
        borderSeven.insets = UIEdgeInsets(top: -1, left: -10, bottom: -1, right: -10)
        seven.textBackgroundBorder = borderSeven
        let highlightBorder = YYTextBorder(lineStyle: .single, lineWidth: 0.5, stroke: UIColor.red)
        highlightBorder.cornerRadius = 50
        highlightBorder.insets = UIEdgeInsets(top: -1, left: -10, bottom: -1, right: -10)
        highlightBorder.fillColor = UIColor.red
        highlightBorder.strokeWidth = 0
        
        let highlight = YYTextHighlight()
        highlight.setColor(UIColor.white)
        highlight.setBackgroundBorder(highlightBorder)
        highlight.tapAction = { (containerView, text, range, rect) in
            
        }
        seven.setTextHighlight(highlight, range: seven.rangeOfAll())
        text.append(seven)
        text.append(padding())
        
        //Yet Another Link
        let night = NSMutableAttributedString(string: "Yet Another Link")
        night.font = UIFont.boldSystemFont(ofSize: 30)
        night.color = UIColor.white
        
        let shadowNight = YYTextShadow(color: UIColor(white: 0.00, alpha: 0.490), offset: CGSize(width: 0, height: 1), radius: 5)
        night.textShadow = shadowNight
        
        let hightlightedShadowNight0 = YYTextShadow(color: UIColor(white: 0.00, alpha: 0.2), offset: CGSize(width: 0, height: -1), radius: 1.5)
        let hightlightedShadowNight1 = YYTextShadow(color: UIColor(white: 0.00, alpha: 0.99), offset: CGSize(width: 0, height: 1), radius: 1.5)
        hightlightedShadowNight0.sub = hightlightedShadowNight1
        
        
        let innerShadowNight = YYTextShadow(color: UIColor(red: 0.851, green: 0.311, blue: 0.000, alpha: 0.780), offset: CGSize(width: 0, height: 1), radius: 1)
        
        let hightlightedNight = YYTextHighlight()
        hightlightedNight.setShadow(hightlightedShadowNight0)
        hightlightedNight.setInnerShadow(innerShadowNight)
        hightlightedNight.setColor(UIColor(red: 1.000, green: 0.795, blue: 0.014, alpha: 1.000))
        night.setTextHighlight(hightlightedNight, range: night.rangeOfAll())
        text.append(night)
        text.append(padding())
    
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    func padding() -> NSAttributedString {
        let pad = NSMutableAttributedString(string: "\n\n")
        pad.font = UIFont.systemFont(ofSize: 1)
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
