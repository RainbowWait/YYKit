//
//  CustomLayout.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/24.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit


//public struct ColumnData {
//    var number = 0
//    var height:CGFloat = 0
//
//    init(number: Int = 0, height: CGFloat = 0) {
//        self.number = number
//        self.height = height
//    }
//}

//fileprivate enum SortEnum {
//    case asc//升序
//    case des//降序
//}
//class CustomLayout<T: UICollectionViewCell>: UICollectionViewLayout {
//
//    
//    //MARK: - 公共属性
//    /** 列数 */
//    public var columnNumber = 2
//    /** 列间距 */
//    public var interitemSpacing: CGFloat = 5.0
//    /** 行间距 */
//    public var lineSpacing: CGFloat = 5.0
//    ///顶部和底部是否留距离
//    public var topAndBottomSpacing = false
//    
//    //MARK: - 私有属性
//    /// 所有的layoutAttribute
//    private var arrLayoutAttributes: [UICollectionViewLayoutAttributes] = {
//        return [UICollectionViewLayoutAttributes]()
//    }()
//    ///所有Item高度
//    private var arrItemSize: [CGSize] = {
//        return [CGSize]()
//    }()
//    
//    private var arrColumn: [ColumnData] = {
//        return [ColumnData]()
//    }()
//    
//    private var templateCell: T?
//    private var itemWidth: CGFloat = 0
//    private var insets: UIEdgeInsets!
//    private var bounds: CGRect!
//     init(_ type: T.Type) {
//        super.init()
//        let name = "\(type)"
//        templateCell = Bundle.main.loadNibNamed(name, owner: self, options: nil)?.last as? T
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    override func prepare() {
//        super.prepare()
//        bounds = self.collectionView?.bounds ?? CGRect.zero
//        insets = self.collectionView?.contentInset ?? UIEdgeInsets.zero
//        let contentWidth = bounds.width - insets.left - insets.right
//        let column = CGFloat(columnNumber)
//        itemWidth = (contentWidth - (column - 1) * interitemSpacing) / column
//        
//    }
//    
//    func calculateAttributesWithItemWidth(_ width: CGFloat) {
//        self.refreshLayoutCache()
//    }
//    
//    func refreshLayoutCache()  {
//        arrLayoutAttributes.removeAll()
//        arrItemSize.removeAll()
//        arrColumn.removeAll()
//        for i in 0..<columnNumber {
//            arrColumn.append(ColumnData(number: i, height: insets.top))
//        }
//    }
//}

