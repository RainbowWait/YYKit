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

    @IBOutlet weak var label: YYLabel!

    @IBOutlet weak var img: UIImageView!
//    var label: YYLabel!
//    var img: UIImageView!
    
    
    var model: ActivityModel? {
        didSet{
            
            self.layoutIfNeeded()
            self.setNeedsLayout()
            self.label.preferredMaxLayoutWidth = self.label.frame.width - 20
            label.text = model?.title
            if model?.titlepic != nil && !(model?.titlepic.isEmpty)! {
                img.image = UIImage(data: try! Data.init(contentsOf: URL(string: (model?.titlepic)!)!))
                
            }
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.textVerticalAlignment = .top
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 17)
        self.contentView.backgroundColor = UIColor.yellow
//        label.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
//        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        self.contentView.setContentHuggingPriority(.defaultLow, for: .vertical)
//        self.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
//        self.setContentHuggingPriority(.defaultLow, for: .vertical)
        self.contentView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        self.contentView.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.width.equalTo((UIScreen.main.bounds.width - 10) / 2.0)
            make.bottom.equalTo(self.label.snp.bottom).offset(10).priority(10)
        }
    }

}
