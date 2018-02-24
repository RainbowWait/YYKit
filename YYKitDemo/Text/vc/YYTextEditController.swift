//
//  YYTextEditController.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/9.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class YYTextEditController: UIViewController,YYTextViewDelegate, YYTextKeyboardObserver {
    var textView: YYTextView!
    var imageView: UIImageView!
    var verticalSwitch: UISwitch!
    var debugSwitch: UISwitch!
    var exclusionSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.frame = UIScreen.main.bounds
        self.automaticallyAdjustsScrollViewInsets = false
        self.initImageView()
        let toolBar = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        toolBar.size = CGSize(width: YYScreenSize().width, height: 40)
        toolBar.top = 64
        self.view.addSubview(toolBar)
        let text = NSMutableAttributedString(string: "It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the season of light, it was the season of darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us. We were all going direct to heaven, we were all going direct the other way.\n\n这是最好的时代，这是最坏的时代；这是智慧的时代，这是愚蠢的时代；这是信仰的时期，这是怀疑的时期；这是光明的季节，这是黑暗的季节；这是希望之春，这是失望之冬；人们面前有着各样事物，人们面前一无所有；人们正在直登天堂，人们正在直下地狱。")
        text.font = UIFont(name: "Times New Roman", size: 20)
        text.lineSpacing = 4
        text.firstLineHeadIndent = 20
        
        let textView = YYTextView()
        textView.attributedText = text
        textView.size = self.view.size
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.delegate = self
        textView.keyboardDismissMode = .interactive
        textView.contentInset = UIEdgeInsets(top: toolBar.bottom, left: 0, bottom: 0, right: 0)
        textView.scrollIndicatorInsets = textView.contentInset
        textView.selectedRange = NSRange(location: text.length, length: 0)
        self.view.insertSubview(textView, belowSubview: toolBar)
        self.textView = textView
        
        //ToolBar
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Vertical:"
        let width = (label.text! as NSString).width(for: label.font) + 1
        
        label.size = CGSize(width: width, height: toolBar.height)
        label.left = 10
        toolBar.contentView.addSubview(label)
        
        verticalSwitch = UISwitch()
        verticalSwitch.sizeToFit()
        verticalSwitch.centerY = toolBar.height / 2
        verticalSwitch.left = label.right - 5
        verticalSwitch.layer.transformScale = 0.8
        verticalSwitch.addBlock(for: .valueChanged) { (sender) in
            let switcher = sender as! UISwitch
            
            self.textView.endEditing(true)
            if switcher.isOn {
                self.setExclusionPathEnabled(enabled: false)
                self.exclusionSwitch.isOn = false
            }
            self.exclusionSwitch.isEnabled = !switcher.isOn
            self.textView.isVerticalForm = switcher.isOn
        }
        toolBar.contentView.addSubview(verticalSwitch)
        
        let labelDebug = UILabel()
        labelDebug.backgroundColor = UIColor.clear
        labelDebug.font = UIFont.systemFont(ofSize: 14)
        labelDebug.text = "Debug:"
        labelDebug.size = CGSize(width: (labelDebug.text! as NSString).width(for: label.font) + 2, height: toolBar.height)
        label.left = verticalSwitch.right + 5
        toolBar.contentView.addSubview(labelDebug)
        
        debugSwitch = UISwitch()
        debugSwitch.sizeToFit()
        debugSwitch.isOn = YYTextExampleHelper.DebugEnabled
        debugSwitch.centerY = toolBar.height / 2
        debugSwitch.left = label.right - 5
        debugSwitch.layer.transformScale = 0.8
        debugSwitch.addBlock(for: .valueChanged) { (sender) in
            let switcher = sender as! UISwitch
            
            YYTextExampleHelper.setDebug(debug: switcher.isOn)
        }
        toolBar.contentView.addSubview(debugSwitch)
        
        let labelExclusion = UILabel()
        labelExclusion.backgroundColor = UIColor.clear
        labelExclusion.font = UIFont.systemFont(ofSize: 14)
        labelExclusion.text = "Exclusion:"
        labelExclusion.size = CGSize(width: (labelExclusion.text! as NSString).width(for: labelExclusion.font), height: toolBar.height)
        labelExclusion.left = debugSwitch.right + 5
        toolBar.contentView.addSubview(labelExclusion)
        
        exclusionSwitch = UISwitch()
        exclusionSwitch.sizeToFit()
        exclusionSwitch.centerY = toolBar.height / 2
        exclusionSwitch.left = labelExclusion.right - 5
        exclusionSwitch.layer.transformScale = 0.8
        exclusionSwitch.addBlock(for: .valueChanged) { (sender) in
            let switcher = sender as! UISwitch
            self.setExclusionPathEnabled(enabled: switcher.isOn)
        }
        
        toolBar.contentView.addSubview(exclusionSwitch)
        YYTextKeyboardManager.default()?.add(self)
    }
    
    deinit {
        YYTextKeyboardManager.default()?.remove(self)
    }
    
    func setExclusionPathEnabled(enabled: Bool) {
        if enabled {
            self.textView.addSubview(self.imageView)
            let path = UIBezierPath(roundedRect: self.imageView.frame, cornerRadius: self.imageView.layer.cornerRadius)
            self.textView.exclusionPaths = [path]
            
        } else {
            self.imageView.removeFromSuperview()
            self.textView.exclusionPaths = nil
        }
    }
    
    func initImageView() {
        let data = NSData(named: "dribbble256_imageio.png")
        let image = YYImage(data: Data(referencing: data!))
        let imageView = YYAnimatedImageView(image: image)
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = imageView.height / 2
        imageView.center = CGPoint(x: YYScreenSize().width / 2, y: YYScreenSize().width / 2)
        self.imageView = imageView
        let g = UIPanGestureRecognizer {[unowned self] (sender) in
            let p = (sender as! UIPanGestureRecognizer).location(in: self.textView)
            self.imageView.center = p
            let path = UIBezierPath(roundedRect: self.imageView.frame, cornerRadius: self.imageView.layer.cornerRadius)
            self.textView.exclusionPaths = [path]
        }
        imageView.addGestureRecognizer(g)
        
    }
    
    //YYTextViewDelegate
    func textViewDidBeginEditing(_ textView: YYTextView) {
        let buttonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(edit(_:)))
        self.navigationItem.rightBarButtonItem = buttonItem
        
    }
    
    func textViewDidEndEditing(_ textView: YYTextView) {
        self.navigationItem.rightBarButtonItem = nil
    }
    
    @objc func edit(_ item: UIBarButtonItem) {
        if textView.isFirstResponder {
            textView.resignFirstResponder()
        } else {
            textView.becomeFirstResponder()
        }
    }

//YYKeyboardDelegate
    func keyboardChanged(with transition: YYTextKeyboardTransition) {
        var clipped = false
        if textView.isVerticalForm && transition.toVisible.boolValue {
            let rect = YYTextKeyboardManager.default()?.convert(transition.toFrame, to: self.view)
            if rect?.maxY == self.view.height {
                var textFrame = self.view.bounds
                textFrame.size.height -= (rect?.size.height)!
                textView.frame = textFrame
                clipped = true
                
            }
            
        }
        if !clipped {
            textView.frame = self.view.bounds
        }
        
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

