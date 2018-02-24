
//
//  AsyncCell.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/23.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class AsyncCell: UITableViewCell {

    var async: Bool? {
        didSet{
            if async != oldValue {
                uiLabel.isHidden = async!
                yyLabel.isHidden = !async!
            }
        }
    }
    var uiLabel: UILabel!
    var yyLabel: YYLabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        uiLabel = UILabel()
        uiLabel.font = UIFont.systemFont(ofSize: 8)
        uiLabel.numberOfLines = 0
        uiLabel.size = CGSize(width: YYScreenSize().width, height: 34)
        yyLabel = YYLabel()
        yyLabel.font = uiLabel.font
        yyLabel.numberOfLines = UInt(uiLabel.numberOfLines)
        yyLabel.size = uiLabel.size
        yyLabel.displaysAsynchronously = true
        yyLabel.isHidden = true
        self.contentView.addSubview(uiLabel)
        self.contentView.addSubview(yyLabel)
    }
    
    func setAyncText(text: Any) {
        if async! {
            yyLabel.layer.contents = nil
            yyLabel.textLayout = (text as! YYTextLayout)
        } else {
            uiLabel.attributedText = (text as! NSAttributedString)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
