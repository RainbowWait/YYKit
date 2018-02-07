//
//  YYAnimatedImageController.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/6.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class YYAnimatedImageController: UIViewController {
    
    var imageView: UIImageView!
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Animated Image"
        self.view.frame = UIScreen.main.bounds
        print(self.view.frame,UIScreen.main.bounds)
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 375, height: self.view.height))
        self.scrollView.backgroundColor = UIColor.red
        self.scrollView.bounces = true
        self.view.addSubview(scrollView)
        
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.frame = CGRect(x: 0, y: 0, width: self.view.width, height: 60)
        label.size = CGSize(width: self.view.width, height: 60)
        label.top = 20
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Tap the image to pause/play\n Slide on the image to forward/rewind"
        scrollView.addSubview(label)
        self.addImageWithName(name: "niconiconi", text: "Animated GIF")
        //        self.addImageWithName(name: "wall-e.webp", text: "Animated WebP")
        self.addImageWithName(name: "pia", text: "Animated PNG (APNG)")
        self.addFrameImageWithText(text: "Frame Animation")
        self.addSpriteSheetImageWithText(text: "Sprite Sheet Animation")
    }
    
    //MARK: - Sprite Sheet Image
    func addSpriteSheetImageWithText(text: String) {
        let path = Bundle.main.bundlePath.appending("/ResourceTwitter.bundle/fav02l-sheet@2x.png")
        let sheet = UIImage(data:try! Data.init(referencing: NSData(contentsOfFile: path)),scale: 2)
        let size = CGSize(width: (sheet?.size.width)! / 8, height: (sheet?.size.height)! / 12)
        var contentRects: [NSValue] = [NSValue]()
        var durations: [NSNumber] = [NSNumber]()
        for j in 0..<12 {
            for i in 0..<8 {
                var rect: CGRect = CGRect.zero
                rect.size = size
                rect.origin.x = (sheet?.size.width)! / 8 * CGFloat(i)
                rect.origin.y = (sheet?.size.height)! / 12 * CGFloat(j)
                contentRects.append(NSValue.init(cgRect: rect))
                durations.append(NSNumber.init(value: 1 / 60.0))
            }
        }
        let sprite = YYSpriteSheetImage(spriteSheetImage: sheet!, contentRects: contentRects, frameDurations: durations, loopCount: 0)
        self.addImage(image: sprite!, size: size, text: text)
        
        
        
        
    }
    
    //MARK: -YY Frame Image
    func addFrameImageWithText(text: String) {
        let basePath = Bundle.main.bundlePath.appending("/EmoticonWeibo.bundle/com.sina.default")
        var paths: [String] = [String]()
        paths.append(basePath.appending("/d_aini@3x.png"))
        paths.append(basePath.appending("/d_baibai@3x.png"))
        paths.append(basePath.appending("/d_chanzui@3x.png"))
        paths.append(basePath.appending("/d_chijing@3x.png"))
        paths.append(basePath.appending("/d_dahaqi@3x.png"))
        paths.append(basePath.appending("/d_guzhang@3x.png"))
        paths.append(basePath.appending("/d_haha@2x.png"))
        paths.append(basePath.appending("/d_haixiu@3x.png"))
        let image = YYFrameImage(imagePaths: paths, oneFrameDuration: 0.2, loopCount: 0)
        self.addImage(image: image!, size: CGSize.zero, text: text)
        
        
        
        
    }
    //MARK: - YY Image
    func addImageWithName(name: String, text: String
        ) {
        let image = YYImage(named: name)
        self.addImage(image: image!, size: CGSize.zero, text: text)
        
    }
    func addImage(image: UIImage, size: CGSize, text: String) {
        let imageView = YYAnimatedImageView(image: image)
        if size.width > 0 && size.height > 0 {
            imageView.size = size
        }
        imageView.centerX = self.view.width / 2
        imageView.top = (scrollView.subviews.last?.bottom)! + 30
        imageView.contentMode = .scaleAspectFit
        self.scrollView.addSubview(imageView)
        let imageLabel = UILabel()
        imageLabel.backgroundColor = UIColor.clear
        imageLabel.frame = CGRect(x: 0, y: 0, width: self.view.width, height: 20)
        imageLabel.top = imageView.bottom + 10
        imageLabel.textAlignment = .center
        imageLabel.text = text
        scrollView.addSubview(imageLabel)
        scrollView.contentSize = CGSize(width: self.view.width, height: imageLabel.bottom + 20)
        
        //        }
        print(scrollView.frame, scrollView.contentSize,scrollView.contentOffset,self.view.frame)
        
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
