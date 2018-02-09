//
//  YYWebImageExampleCell.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/8.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class YYWebImageExampleCell: UITableViewCell {

    var webImageView: YYAnimatedImageView!
    var indicator: UIActivityIndicatorView!
    var progressLayer: CAShapeLayer!
    var label: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
        self.size = CGSize(width: YYScreenSize().width, height: YYScreenSize().width * 3.0 / 4.0)
        webImageView = YYAnimatedImageView()
        webImageView.size = self.size
        webImageView.clipsToBounds = true
        webImageView.contentMode = .scaleAspectFill
        webImageView.backgroundColor = UIColor.white
        self.contentView.addSubview(webImageView)
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.center = CGPoint(x: self.width / 2, y: self.height / 2)
        self.contentView.addSubview(indicator)
        indicator.isHidden = true
        label = UILabel()
        label.size = self.size
        label.textAlignment = .center
        label.text = "Load fail, tap to reload."
        label.textColor = UIColor(white: 0.7, alpha: 1.0)
        label.isHidden = true
        label.isUserInteractionEnabled = true
        self.contentView.addSubview(label)
        
        let lineHeight: CGFloat = 4
        progressLayer = CAShapeLayer()
        progressLayer.size = CGSize(width: webImageView.width, height: lineHeight)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: progressLayer.height / 2))
        path.addLine(to: CGPoint(x: webImageView.width, y: progressLayer.height / 2))
        progressLayer.lineWidth = lineHeight
        progressLayer.path = path.cgPath
        progressLayer.strokeColor = UIColor(red: 0, green: 0.64, blue: 1.0, alpha: 0.72).cgColor
        progressLayer.lineCap = kCALineCapButt
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 0
        webImageView.layer.addSublayer(progressLayer)
        let tap = UITapGestureRecognizer { (sender) in
            self.setImageUrl(url: self.webImageView.imageURL!)
        }
        label.addGestureRecognizer(tap)
        
        
        
        
        
    }
    
    func setImageUrl(url: URL) {
        label.isHidden = true
        indicator.isHidden = false
        indicator.startAnimating()
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.progressLayer.isHidden = false
        self.progressLayer.strokeEnd = 0
        CATransaction.commit()
        webImageView.setImageWith(url, placeholder: nil, options: [.progressiveBlur, .showNetworkActivity, .setImageWithFadeAnimation], progress: { (receivedSize, expectedSize) in
            if expectedSize > 0 && receivedSize > 0 {
                var progress = Float(receivedSize) / Float(expectedSize)
                progress = progress < 0 ? 0 : (progress > 1 ? 1 : progress)
                if !self.progressLayer.isHidden{
                    self.progressLayer.isHidden = false
                    self.progressLayer.strokeEnd = CGFloat(progress)
                    print("progress = \(progress)")
                }
            }
            print(receivedSize, expectedSize)
            
        }, transform: nil) { (image, url, from, stage, error) in
            if stage == YYWebImageStage.finished {
                self.progressLayer.isHidden = true
                self.indicator.isHidden = true
                if image == nil {
                    self.label.isHidden = false
                }
            }
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
