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

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    var model: ActivityModel? {
        didSet{
            self.label.numberOfLines = 2
//            label.textVerticalAlignment = .top
            label.text = model?.title
            if model?.titlepic != nil && !(model?.titlepic.isEmpty)! {
                img.image = UIImage(data: try! Data.init(contentsOf: URL(string: (model?.titlepic)!)!))
                
            }
        }
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

}
