//
//  YYImageExampleHelper.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/12.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import ImageIO
import Accelerate
import YYKit

class YYImageExampleHelper: NSObject {
    public class func addTapControlToAnimatedImageView(view: YYAnimatedImageView) {
        guard view != nil else {
            return
        }
        
        let tap = UITapGestureRecognizer { (sender) in
            if view.isAnimating {
                view.stopAnimating()
            } else {
                view.startAnimating()
            }
            
            //add a 'bounce' animation
            let options:UIViewAnimationOptions = [.curveEaseOut, .allowAnimatedContent, .beginFromCurrentState]
            UIView.animate(withDuration: 0.1, delay: 0, options: options, animations: {
                view.layer.transformScale = 1.008
            }, completion: { (finished) in
                UIView.animate(withDuration: 0.1, delay: 0, options: options, animations: {
                    view.layer.transformScale = 1
                }, completion: nil)
            })
        }
        view.addGestureRecognizer(tap)
    }
    
    class func addPanControlToAnimatedImageView(view: YYAnimatedImageView) {
        view.isUserInteractionEnabled = true
        var previousIsPlaying: Bool = false
        let pan = UIPanGestureRecognizer { (sender) in
            let image: YYAnimatedImage = view.image as! YYAnimatedImage
//            if !image.conforms(to: YYAnimatedImage.self) {
//                return
//            }
            let gesture = sender as! UIPanGestureRecognizer
            let p = gesture.location(in: gesture.view)
            let progress = p.x / (gesture.view?.width)!
            if gesture.state == .began {
                previousIsPlaying = view.isAnimating
                view.stopAnimating()
                view.currentAnimatedImageIndex =
                    UInt(fabs(CGFloat(image.animatedImageFrameCount()) * progress))
            } else if gesture.state == .ended || gesture.state == .cancelled {
                if previousIsPlaying {
                    view.startAnimating()
                }
            } else {
            
                let i = UInt(0.0)
                
                view.currentAnimatedImageIndex = UInt(fabs(CGFloat(image.animatedImageFrameCount()) * progress))
            }
        }
        view.addGestureRecognizer(pan)
    }
    
}
