//
//  TestCell.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/26.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class TestCell: UICollectionViewCell {
    
    var label: YYLabel!
    var imageView: UIImageView!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.yellow
        self.imageView = UIImageView()
        self.contentView.addSubview(imageView)
        
        self.label = YYLabel()
        self.contentView.addSubview(self.label)
        self.label.textAlignment = .justified
        self.label.numberOfLines = 0
        self.label.textVerticalAlignment = .top
        self.label.font = UIFont.systemFont(ofSize: 17)
        //        self.label.textContainerInset = UIEdgeInsetsMake(10, 0, 0, 10);
        //        self.label.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        self.label.text = "11111111111111111111111111111111111111111111111111111111111111111111111111111"
        self.creatAutoLayout()
    }
    
    var model: ActivityModel? {
        didSet{
            self.layoutIfNeeded()

            //            label.textVerticalAlignment = .top
            
            if model?.titlepic != nil && !(model?.titlepic.isEmpty)! {
                imageView.image = UIImage(data: try! Data.init(contentsOf: URL(string: (model?.titlepic)!)!))
                
            }
            self.label.text = model?.title

//            self.label.height = (model?.title as! NSString).height(for: label.font, width: self.label.frame.width) + 1
            
        }
    }
    
    func creatAutoLayout() {
        let width: CGFloat = (UIScreen.main.bounds.width - 10.0 * 2 - 5.0) / 2.0
        //        let width = UIScreen.main.bounds.width
        self.contentView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        self.contentView.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.width.equalTo(width)
            make.bottom.equalTo(self.label.snp.bottom).offset(15).priority(250)
        }
        self.imageView.snp.makeConstraints { (make) in
            make.left.width.top.equalTo(self.contentView)
            make.height.equalTo(100)
        }
        
        self.label.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom).offset(10)
            make.left.equalTo(self.imageView).offset(0)
            make.right.equalTo(self.imageView).offset(0)
            
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        self.setNeedsLayout()
        self.layoutIfNeeded()
        let size = self.contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var cellFrame = layoutAttributes.frame
        cellFrame.size.height = size.height
        layoutAttributes.frame = cellFrame
        return layoutAttributes
    }
    
}
