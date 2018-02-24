//
//  YYTextEmotionController.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/9.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class YYTextEmotionController: UIViewController,YYTextViewDelegate {

    var textView: YYTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.frame = UIScreen.main.bounds
        self.automaticallyAdjustsScrollViewInsets = false
        let mapper = [":smile:": imageWithName(name: "002@2x"), ":cool:": imageWithName(name: "013@2x"), ":biggrin:": imageWithName(name: "047@2x"), ":arrow:": imageWithName(name: "007@2x"), ":confused:": imageWithName(name: "041@2x"), ":cry:": imageWithName(name: "010@2x"), ":wink:": imageWithName(name: "085@2x")]
        let parser = YYTextSimpleEmoticonParser()
        parser.emoticonMapper = mapper
        let mod: YYTextLinePositionSimpleModifier = YYTextLinePositionSimpleModifier()
        mod.fixedLineHeight = 22
        let textView = YYTextView()
        textView.text = "Hahahah:smile:, it\'s emoticons::cool::arrow::cry::wink:\n\nYou can input \":\" + \"smile\" + \":\" to display smile emoticon, or you can copy and paste these emoticons.\n\nSee \'YYTextEmoticonExample.m\' for example."
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textParser = parser
        textView.size = self.view.size
        textView.linePositionModifier = mod
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.delegate = self
        textView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        textView.scrollIndicatorInsets = textView.contentInset
        self.view.addSubview(textView)
        self.textView = textView
        self.textView.becomeFirstResponder()
        
        
        
        
        
        
        
    }
    
    func imageWithName(name: String) -> UIImage {
        let bundle = Bundle.main.path(forResource: name, ofType: "gif", inDirectory: "EmoticonQQ.bundle")
        let data = NSData(contentsOfFile: bundle!)
        let image = YYImage(data: Data(referencing: data!), scale: 2)
        image?.preloadAllAnimatedImageFrames = true
        return image!
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
