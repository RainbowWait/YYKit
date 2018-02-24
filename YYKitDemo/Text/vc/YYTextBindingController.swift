//
//  YYTextBindingController.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/9.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class YYTextBindingController: UIViewController, YYTextViewDelegate {
    var textView: YYTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = UIScreen.main.bounds
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        let text = NSMutableAttributedString(string: "sjobs@apple.com, apple@apple.com, banana@banana.com, pear@pear.com ")
        text.font = UIFont.systemFont(ofSize: 17)
        text.lineSpacing = 5
        text.color = UIColor.black
        let textView = YYTextView()
        textView.attributedText = text
        textView.textParser = YYTextExampleEmailBindingParser()
        textView.size = self.view.size
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.delegate = self
        textView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        textView.scrollIndicatorInsets = textView.contentInset
        
        self.view.addSubview(textView)
        self.textView = textView
        self.textView.becomeFirstResponder()
        
        
        
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

class YYTextExampleEmailBindingParser: NSObject, YYTextParser {
    var regex: NSRegularExpression!
    override init() {
        super.init()
        let pattern = "[-_a-zA-Z0-9@\\.]+[ ,\\n]"
        self.regex = try? NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
        
    }
    
    func parseText(_ text: NSMutableAttributedString?, selectedRange: NSRangePointer?) -> Bool {
        var changed = false
        regex.enumerateMatches(in: (text?.string)!, options: .withoutAnchoringBounds, range: (text?.rangeOfAll())!) { (result, flags, stop) in
            let range: NSRange = (result?.range)!
            if range.location == NSNotFound || range.length < 1 {
                return
            }
            if ((text?.attribute(NSAttributedStringKey(rawValue: YYTextBindingAttributeName), at: range.location, effectiveRange: nil)) != nil) {
                
                return
            }
            let bindlingRange = NSRange(location: range.location, length: range.length - 1)
            let binding = YYTextBinding(deleteConfirm: true)
            text?.setTextBinding(binding, range: bindlingRange)
            text?.setColor(UIColor(red: 0.000, green: 0.519, blue: 1.000, alpha: 1.000), range: bindlingRange)
            changed = true
        }
        return changed
        
    }
    
    
}
