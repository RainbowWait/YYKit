//
//  CustomCollectionViewCell.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/3/2.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
//       self.img.layer.cornerRadius = img.bounds.height / 2.0
//        self.img.clipsToBounds = true
//        self.img.layer.borderWidth = 1
//        self.img.layer.borderColor = UIColor.lightGray.cgColor
        
        let path = UIBezierPath()
        let width = self.img.bounds.width
        let height = self.img.bounds.height
        let angle = CGFloat.pi / 4
        
        let centerX = self.img.centerX
        let centerY = self.img.centerY
        let cosValue = cos(angle)
        let sinValue = sin(angle)
        path.move(to: CGPoint(x: centerX + width / 2 * cosValue, y: centerY - width / 2 * sinValue))
        path.addArc(withCenter: CGPoint(x: centerX, y: centerY), radius: width / 2, startAngle: -angle, endAngle: angle, clockwise: false)
        
                path.addArc(withCenter: CGPoint(x: centerX + width * cosValue , y: centerY), radius: width / 2, startAngle: CGFloat.pi - angle, endAngle: CGFloat.pi + angle, clockwise: true)
        path.close()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        self.img.layer.mask = shape
        
        
//        path.move(to: CGPoint(x: centerX + width / 2 * cosValue, y: centerY - height / 2 * sinValue))
//        path.addArc(withCenter: CGPoint(x: centerX +  width * cosValue , y: centerY), radius: width / 2, startAngle: CGFloat.pi * 11 / 6, endAngle: -CGFloat.pi * 5 / 6, clockwise: false)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
        
        
        
        
    }
    var model: ActivityModel? {
        didSet{
     
            if model?.titlepic != nil && !(model?.titlepic.isEmpty)! {
                img.image = UIImage(data: try! Data.init(contentsOf: URL(string: (model?.titlepic)!)!))
                
            }
        }
    }

}
