//
//  ActivityOnModel.swift
//  ShangYouNews
//
//  Created by 郑小燕 on 2017/5/9.
//  Copyright © 2017年 baymax. All rights reserved.
//

import UIKit
import HandyJSON
class ActivityListModel: HandyJSON {
     var db               : [ActivityModel]?
     var msg              : String = ""
    required init() {
        
    }
}

class ActivityModel: HandyJSON {
    
     var id              = 0
     var istop           = 0
     var istop_name      = ""
     var newstime        = ""
    var pv              = 0
     var starttime       = ""
     var endtime         = ""
     var title           = ""
     var titlepic        = ""
     var titleurl        = ""
    var type            = 0
     var type_name       = ""
     var smalltext       = "来自上游新闻客户端"
    required init() {
        
    }
    
}
