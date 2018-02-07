//
//  VCModel.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/5.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit

class VCModel: NSObject {
    var vcName: String = ""
    var title: String = ""
    init(_ vcName: String, _ title: String) {
        self.vcName = vcName
        self.title = title
    }
    
    class func initModel() -> [VCModel] {
        var vcArray: [VCModel] = [VCModel]()
        vcArray.append(VCModel("YYKitDemo.YYImageExampleController", "Image"))
        vcArray.append(VCModel("YYKitDemo.YYTextViewController", "Text"))
        vcArray.append(VCModel("YYKitDemo.FeedListViewController", "Feed List Demo"))
        return vcArray
    }
    
   class func initImageVCModel() -> [VCModel] {
        var vcArray: [VCModel] = [VCModel]()
        vcArray.append(VCModel("YYKitDemo.YYAnimatedImageController", "Animated Image"))
        vcArray.append(VCModel("YYKitDemo.YYImageProgressiveExample", "Progressive Image"))
        vcArray.append(VCModel("YYKitDemo.YYWebImageExample", "Web Image"))
        return vcArray
    }
    
}

