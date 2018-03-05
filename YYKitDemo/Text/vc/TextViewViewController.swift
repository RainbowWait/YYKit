//
//  TextViewViewController.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/3/1.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class TextViewViewController: UIViewController, UITextViewDelegate {

    typealias sizeBlock = (_ contentSize: CGSize)->Void
    var textView: UITextView!
    var contentHeight: CGFloat = 0
    let topInset: CGFloat = 8
    let fontSize: CGFloat = 17
    let lineHeight = UIFont.systemFont(ofSize: 17).lineHeight
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        textView = UITextView()
        self.view.frame = UIScreen.main.bounds
        textView.frame = CGRect(x: 60, y: 320, width: self.view.bounds.width - 120, height:lineHeight + 2 * topInset)
        self.textView.font = UIFont.systemFont(ofSize: 17)
        self.textView.delegate = self
        self.view.addSubview(textView)
        self.textView.textAlignment = .justified
        self.textView.textContainerInset = UIEdgeInsets(top: topInset, left: 6, bottom: topInset, right: 6)
        self.textView.contentSize = CGSize(width: self.textView.frame.width, height: lineHeight + 2 * topInset)
        print("self.textView.contentSize.heigh = \(self.textView.contentSize.height)== lineHeight = \(lineHeight)")
        self.contentHeight = self.textView.contentSize.height
        self.textView.backgroundColor = UIColor.yellow
        self.textView.layer.cornerRadius = 6
        self.textView.layer.borderWidth = 1
        self.textView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    func textViewDidChange(_ textView: UITextView) {
        let contentSize = textView.contentSize
        if contentSize.height > lineHeight * 4 {

//            self.textView.layoutIfNeeded()
            print("contentSize = \(contentSize)")
            
        }
        if contentSize.height > lineHeight + 2 * topInset {
                        self.textView.textContainerInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
        } else {
           self.textView.textContainerInset = UIEdgeInsets(top: topInset, left: 6, bottom: topInset, right: 6)
        }
        var height = textView.frame.size.height
        if contentHeight != self.textView.contentSize.height {
            height = self.textView.contentSize.height
        } else {
            
        }
        var frame = self.textView.frame
        frame.origin.y -= height - frame.size.height
        frame.size.height = height
//        if height > 4 * lineHeight {
//            frame.size.height = 4 * lineHeight
//            frame.origin.y =  320 - 4 * lineHeight
//        }
        
        
            self.textView.frame = frame
            self.textView.scrollToBottom()
        

                print("contentSize = \(contentSize),textView.size = \(textView.size), textView.textContainerInset = \(textView.textContainerInset)")
    }
    func textViewDidChange(_ textView: YYTextView) {
        let contentSize = textView.contentSize
        let height = contentSize.height + 1
        var frame = self.textView.frame
        frame.origin.y -= height - frame.size.height
        frame.size.height = height
        self.textView.frame = frame
        self.textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        print(contentSize,textView.size, textView.textContainerInset)
        
        
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
