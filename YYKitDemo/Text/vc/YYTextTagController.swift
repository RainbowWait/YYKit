//
//  YYTextTagController.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/9.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class YYTextTagController: UIViewController {

    var textView: YYTextView!
    
    var tags = ["◉red", "◉orange", "◉yellow", "◉green", "◉blue", "◉purple", "◉gray"]
    var tagStrokeColors = [UIColor(hexString: "fa3f39"), UIColor(hexString: "f48f25"), UIColor(hexString: "f1c02c"), UIColor(hexString: "54bc2e"), UIColor(hexString: "29a9ee"), UIColor(hexString: "c171d8"), UIColor(hexString: "818e91")]
        var tagFillColors = [UIColor(hexString: "fb6560"), UIColor(hexString: "f6a550"), UIColor(hexString: "f3cc56"), UIColor(hexString: "76c957"), UIColor(hexString: "53baf1"), UIColor(hexString: "cd8ddf"), UIColor(hexString: "a4a4a7")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       self.view.frame = UIScreen.main.bounds
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        let text = NSMutableAttributedString()
        
        let font = UIFont.boldSystemFont(ofSize: 16)
        for i in 0..<tags.count {
            let tag = tags[i]
            let tagStrokeColor = tagStrokeColors[i]
            let tagFillColor = tagFillColors[i]
            let tagText = NSMutableAttributedString(string: tag)
            tagText.insertString("   ", at: 0)
            tagText.appendString("   ")
            tagText.font = font
            tagText.color = UIColor.white
            tagText.setTextBinding(YYTextBinding(deleteConfirm: false), range: tagText.rangeOfAll())
            let border = YYTextBorder(lineStyle: .single, lineWidth: 1.5, stroke: tagStrokeColor)
            border.fillColor = tagFillColor
            border.strokeWidth = 1.5
            border.cornerRadius = 100
            border.insets = UIEdgeInsets(top: -2, left: -5.5, bottom: -2, right: -8)
            tagText.setTextBackgroundBorder(border, range: (tagText.string as NSString).range(of: tag))
            text.append(tagText)
        }
        
        text.lineSpacing = 10
        text.lineBreakMode = .byWordWrapping
        text.appendString("\n")
        text.append(text)
        let textView = YYTextView()
        textView.attributedText = text
        textView.size = self.view.size
        textView.textContainerInset = UIEdgeInsets(top: 74, left: 10, bottom: 10, right: -10)
        textView.allowsCopyAttributedString = true
        textView.allowsPasteAttributedString = true
        textView.delegate = self
        textView.keyboardDismissMode = .interactive
        textView.scrollIndicatorInsets = textView.contentInset
        textView.selectedRange = NSRange(location: text.length, length: 0)
        self.view.addSubview(textView)
        self.textView = textView
        
        
        
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
extension YYTextTagController: YYTextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: YYTextView) {
        let buttonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(edit(item:)))
        self.navigationItem.rightBarButtonItem = buttonItem
        
    }
    
    
    func textViewDidEndEditing(_ textView: YYTextView) {
        self.navigationItem.rightBarButtonItem = nil
    }
    
    @objc func edit(item: UIBarButtonItem) {
        if textView.isFirstResponder {
            textView.resignFirstResponder()
        } else {
            textView.becomeFirstResponder()
        }
    }
}
