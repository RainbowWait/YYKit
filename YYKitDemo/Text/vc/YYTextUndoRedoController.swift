//
//  YYTextUndoRedoController.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/9.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class YYTextUndoRedoController: UIViewController, YYTextViewDelegate {
    var textView: YYTextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.frame = UIScreen.main.bounds
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        let text = "You can shake the device to undo and redo."
        let textView = YYTextView()
        textView.text = text
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.size = self.view.size
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.delegate = self
        textView.allowsUndoAndRedo = true
        textView.maximumUndoLevel = 10
        textView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        textView.scrollIndicatorInsets = textView.contentInset
        self.view.addSubview(textView)
        self.textView = textView
        textView.selectedRange = NSRange(location: text.count, length: 0)
        textView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
