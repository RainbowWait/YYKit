//
//  YYTextAttachmentController.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/9.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class YYTextAttachmentController: UIViewController {

    var label: YYLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.frame = UIScreen.main.bounds
        let text = NSMutableAttributedString()
        let font = UIFont.systemFont(ofSize: 16)
            let title = "This is UIImage attachment:"
        text.append(NSMutableAttributedString(string: title))
        var image = UIImage(named: "dribbble64_imageio")
        image = UIImage(cgImage: (image?.cgImage)!, scale: 2, orientation: UIImageOrientation.up)
        let attachText = NSMutableAttributedString.attachmentString(withContent: image, contentMode: .center, attachmentSize: (image?.size)!, alignTo: font, alignment: .center)
        text.append(attachText)
        text.append(self.addNewLine())
        
        let title2 = "This is UIView attachment: "
        text.append(NSAttributedString(string: title2))
        let switcher = UISwitch()
        switcher.sizeToFit()
        
        let attachText2 = NSMutableAttributedString.attachmentString(withContent: switcher, contentMode: .center, attachmentSize: switcher.size, alignTo: font, alignment: .center)
        text.append(attachText2)
        text.append(self.addNewLine())
        
        let title3 = "This is Animated Image attachment:"
        text.append(NSAttributedString(string: title3))
        let names = ["001@2x", "022@2x", "019@2x", "056@2x", "085@2x"]
        for name in names {
            let path = Bundle.main.path(forResource: name, ofType: "gif", inDirectory: "EmoticonQQ.bundle")
            let data = NSData(contentsOfFile: path!)
            let image: YYImage = YYImage(data: Data(referencing: data!), scale: 2)!
            image.preloadAllAnimatedImageFrames = true
            let imageView = YYAnimatedImageView(image: image)
            let attachText3 = NSMutableAttributedString.attachmentString(withContent: imageView, contentMode: .center, attachmentSize: imageView.size, alignTo: font, alignment: .center)
            text.append(attachText3)
        }
        let image2 = YYImage(named: "wall-e@2x.webp")
        image2?.preloadAllAnimatedImageFrames = true
        let imageView2 = YYAnimatedImageView(image: image2)
        imageView2.autoPlayAnimatedImage = false
        imageView2.startAnimating()
        
        let attachText4 = NSMutableAttributedString.attachmentString(withContent: imageView2, contentMode: .center, attachmentSize: imageView2.size, alignTo: font, alignment: .center)
        text.append(attachText4)
        text.append(addNewLine())
        label = YYLabel()
        label.isUserInteractionEnabled = true
        label.numberOfLines = 0
        label.textVerticalAlignment = .top
        label.size = CGSize(width: 260, height: 260)
        label.center = CGPoint(x: self.view.width / 2.0, y: self.view.height / 2)
        label.attributedText = text
        self.addSeeMoreButton()
        self.view.addSubview(label)
        label.layer.borderWidth = CGFloatFromPixel(1)
        label.layer.borderColor = UIColor(red: 0.000, green: 0.463, blue: 1.000, alpha: 1.000).cgColor
        let dot = self.newDotView()
        dot.center = CGPoint(x: label.width, y: label.height)
        
        dot.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        label.addSubview(dot)
        let gesture = YYGestureRecognizer()
        gesture.action = { [unowned self] (gest, state) in
            if state != YYGestureRecognizerState.moved {
                return
            }
            let width = gesture.currentPoint.x
            let height = gesture.currentPoint.y
            self.label.width = width < 30 ? 30 : width
            self.label.height = height < 30 ? 30 : height
        }
        gesture.delegate = self
        label.addGestureRecognizer(gesture)
        
    }
    
    func addSeeMoreButton() {
        let text = NSMutableAttributedString(string: "more...")
        let hi = YYTextHighlight()
        hi.setColor(UIColor(red: 0.578, green: 0.790, blue: 1.000, alpha: 1.000))
        hi.tapAction = {[unowned self](containerView,text,range,rect) in
            let labelNew = self.label
            labelNew?.sizeToFit()
        }
        text.setColor(UIColor(red: 0.000, green: 0.449, blue: 1.000, alpha: 1.000), range: (text.string as NSString).range(of: "more"))
        text.setTextHighlight(hi, range: (text.string as NSString).range(of: "more"))
        text.font = label.font
        
        let seeMore = YYLabel()
        seeMore.attributedText = text
        seeMore.sizeToFit()
        
        let truncationToken = NSAttributedString.attachmentString(withContent: seeMore, contentMode: .center, attachmentSize: seeMore.size, alignTo: text.font!, alignment: .center)
        label.truncationToken = truncationToken
        
        
        
    }
    
    
    func newDotView() -> UIView {
        let view = UIView()
        view.size = CGSize(width: 50, height: 50)
        let dot = UIView()
        dot.size = CGSize(width: 10, height: 10)
        dot.backgroundColor = UIColor(red: 0.000, green: 0.463, blue: 1.000, alpha: 1.000)
        dot.clipsToBounds = true
        dot.layer.cornerRadius = dot.height / 2
        dot.center = CGPoint(x: view.width / 2, y: view.height / 2)
        view.addSubview(dot)
        return view
        
        
    }
    
    func addNewLine() -> NSAttributedString {
        let attribute: NSMutableAttributedString = NSMutableAttributedString(string: "\n")
        return attribute
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

extension YYTextAttachmentController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let p = gestureRecognizer.location(in: label)
        if p.x < label.width - 20 {
            return false
        }
        if p.y < label.height - 20 {
            return false
        }
        return true
        
    }
}
