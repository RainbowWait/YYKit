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
        vcArray.append(VCModel(YYImageExampleController.className(), "Image"))
        vcArray.append(VCModel(YYTextViewController.className(), "Text"))
        vcArray.append(VCModel(FeedListViewController.className(), "Feed List Demo"))
        return vcArray
    }
    
   class func initImageVCModel() -> [VCModel] {
        var vcArray: [VCModel] = [VCModel]()
        vcArray.append(VCModel(YYAnimatedImageController.className(), "Animated Image"))
        vcArray.append(VCModel(YYImageProgressiveExample.className(), "Progressive Image"))
        vcArray.append(VCModel(YYWebImageExample.className(), "Web Image"))
    vcArray.append(VCModel(CollectionViewController.className(), "CollectionView自定义高度"))
    vcArray.append(VCModel(CustomLayoutViewController.className(), "自定义CollectionViewLayout"))
        return vcArray
    }
    
   class func initTextVCModel() -> [VCModel] {
   var vcArray: [VCModel] = [VCModel]()
    vcArray.append(VCModel(YYTextAttribute.className(), "Text Attribute1"))
vcArray.append(VCModel(YYTextTagController.className(), "Text Attributes2"))
    vcArray.append(VCModel(YYTextAttachmentController.className(), "Text Attachments"))
    vcArray.append(VCModel(YYTextEditController.className(), "Text Edit"))
    vcArray.append(VCModel(YYTextMarkdowmController.className(), "Text Parser(Markdown)"))
    vcArray.append(VCModel(YYTextEmotionController.className(), "Text Parser(Emotion)"))
    vcArray.append(VCModel(YYTextBindingController.className(), "Text Binding"))
    vcArray.append(VCModel(YYTextCopyPasteController.className(), "Copy and paste"))
    vcArray.append(VCModel(YYTextUndoRedoController.className(), "Undo and Redo"))
    vcArray.append(VCModel(YYTextRubyController.className(), "Ruby Annotation"))
    vcArray.append(VCModel(YYTextAsyncController.className(), "Asyn Display"))
    vcArray.append(VCModel(TextViewViewController.className(), "auto size"))
    return vcArray
    }
    
}

