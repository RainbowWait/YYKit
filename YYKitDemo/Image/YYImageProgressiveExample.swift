//
//  YYImageProgressiveExample.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/6.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class YYImageProgressiveExample: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "\(YYImageProgressiveExample.self)", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var imageView: UIImageView!
    var seg0: UISegmentedControl!
    var seg1: UISegmentedControl!
    var slider0: UISlider!
    var slider1: UISlider!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = UIScreen.main.bounds
        self.view.backgroundColor = UIColor.red
        self.imageView = UIImageView()
        imageView.size = CGSize(width: 300, height: 300)
        imageView.backgroundColor = UIColor(white: 0.79, alpha: 1.0)
        imageView.centerX = self.view.width / 2
        seg0 = UISegmentedControl(items: ["baseline", "progressive/interlaced"])
        seg0.selectedSegmentIndex = 0
        seg0.size = CGSize(width: imageView.width, height: 30)
        seg0.centerX = self.view.width / 2
        seg1 = UISegmentedControl(items: ["JPEG", "PNG", "GIF"])
        seg1.frame = seg0.frame
        seg1.selectedSegmentIndex = 0
        slider0 = UISlider()
        slider0.width = seg0.width
        slider0.sizeToFit()
        slider0.minimumValue = 0
        slider0.maximumValue = 1.05
        slider0.value = 0
        slider0.centerX = self.view.width / 2
        slider1 = UISlider()
        slider1.frame = slider0.frame
        slider1.minimumValue = 0
        slider1.maximumValue = 20
        slider1.value = 0
        
        imageView.top = 74
        seg0.top = imageView.bottom + 10
        seg1.top = seg0.bottom + 10
        slider0.top = seg1.bottom + 10
        slider1.top = slider0.bottom + 10
        
        self.view.addSubview(imageView)
        self.view.addSubview(seg0)
        self.view.addSubview(seg1)
        self.view.addSubview(slider0)
        self.view.addSubview(slider1)
        seg0.addBlock(for: .valueChanged) { (sender) in
            self.changed()
        }
        seg1.addBlock(for: .valueChanged) { (sender) in
            self.changed()
        }
        slider0.addBlock(for: .valueChanged) { (sender) in
            self.changed()
        }
        slider1.addBlock(for: .valueChanged) { (sender) in
            self.changed()
        }
        
        
    }
    
    func changed() {
        var name: String = ""
        if seg0.selectedSegmentIndex == 0 {
            if seg1.selectedSegmentIndex == 0 {
                name = "mew_baseline.jpg"
            } else if seg1.selectedSegmentIndex == 1 {
                name = "mew_baseline.png"
            } else {
                name = "mew_baseline.gif"
            }
        } else {
            if seg1.selectedSegmentIndex == 0 {
                name = "mew_progressive.jpg"
            } else if seg1.selectedSegmentIndex == 1 {
                name = "mew_interlaced.png"
            } else {
                name = "mew_interlaced.gif"
            }
        }
        let data = NSData(contentsOf: URL(string: "https://image2.cqcb.com/d/file/p/2018-02-08/50a1ac3db80b0a5d6c4b79537edd8d62.jpg")!)
            //NSData(named: name)
        var progress = slider0.value
        if progress > 1 {
            progress = 1
        }
        let subData = data?.subdata(with: NSRange(location: 0, length: Int(Float((data?.length ?? 0)) * Float(progress))))
        let decoder = YYImageDecoder(scale: UIScreen.main.scale)
        decoder.updateData(subData, final: false)
        let frame = decoder.frame(at: 0, decodeForDisplay: true)
        let image = frame?.image?.byBlurRadius(CGFloat(slider1.value), tintColor: nil, tintMode: CGBlendMode(rawValue: 0)!, saturation: 1, maskImage: nil)
        imageView.image = image
        
        
        
        
        
        
        
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
