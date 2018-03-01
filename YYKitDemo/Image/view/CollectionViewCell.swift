//
//  CollectionViewCell.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/24.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var label: YYLabel!

    @IBOutlet weak var img: UIImageView!
//    var label: YYLabel!
//    var img: UIImageView!
    
    
    var model: ActivityModel? {
        didSet{
            
            self.layoutIfNeeded()
            self.label.preferredMaxLayoutWidth = self.label.frame.width
            if model?.titlepic != nil && !(model?.titlepic.isEmpty)! {
                img.image = UIImage(data: try! Data.init(contentsOf: URL(string: (model?.titlepic)!)!))
                
            }
            label.text = model?.title
             print("-------\(self.label.frame.height)====\(model?.title)")
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
//        label.textVerticalAlignment = .top
        label.numberOfLines = 2
        label.text = "0000000000000000000000000000000000000000000"
        label.snp.makeConstraints { (make) in
            make.top.equalTo(self.img.snp.bottom).offset(10)
            make.left.equalTo(self.img).offset(10)
            make.right.equalTo(self.img).offset(-10)
        }
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 17)
        self.contentView.backgroundColor = UIColor.yellow
        label.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        self.contentView.setContentHuggingPriority(.defaultLow, for: .vertical)

        self.contentView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
       
        self.contentView.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.width.equalTo((UIScreen.main.bounds.width - 10) / 2.0)
//            make.height.equalTo(180)
           
            make.bottom.equalTo(self.view.snp.bottomMargin).offset(10)
        }
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layoutIfNeeded()
        self.viewController
    }

}

