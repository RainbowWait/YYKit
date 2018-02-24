//
//  YYTextMarkdowmController.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/9.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit
class YYTextMarkdowmController: UIViewController, YYTextViewDelegate {

    var textView: YYTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.frame = UIScreen.main.bounds
        self.automaticallyAdjustsScrollViewInsets = false
        let text = "#Markdown Editor\nThis is a simple markdown editor based on `YYTextView`.\n\n*********************************************\nIt\'s *italic* style.\n\nIt\'s also _italic_ style.\n\nIt\'s **bold** style.\n\nIt\'s ***italic and bold*** style.\n\nIt\'s __underline__ style.\n\nIt\'s ~~deleteline~~ style.\n\n\nHere is a link: [YYKit](https://github.com/ibireme/YYKit)\n\nHere is some code:\n\n\tif(a){\n\t\tif(b){\n\t\t\tif(c){\n\t\t\t\tprintf(\"haha\");\n\t\t\t}\n\t\t}\n\t}\n"
        let parser = YYTextSimpleMarkdownParser()
        parser.setColorWithDarkTheme()
        
        let textView = YYTextView()
        textView.text = text
        textView.textParser = parser
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.size = self.view.size
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.delegate = self
//        textView.keyboardDismissMode = .interactive
        textView.backgroundColor = UIColor.black
        textView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
//
        textView.scrollIndicatorInsets = textView.contentInset
//        textView.selectedRange = NSRange(location: text.count, length: 0)
        self.view.addSubview(textView)
        self.textView = textView
        
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
