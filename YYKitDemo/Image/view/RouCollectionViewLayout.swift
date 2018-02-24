//
//  RouCollectionViewLayout.swift
//  MeiGou
//
//  Created by 王坤 on 2018/2/10.
//  Copyright © 2018年 王坤. All rights reserved.
//

import UIKit
import SnapKit

public struct ColumnData {
    var number = 0
    var height:CGFloat = 0
    
    init(number: Int = 0, height: CGFloat = 0) {
        self.number = number
        self.height = height
    }
}

fileprivate enum SortEnum {
    case asc//升序
    case des//降序
}

open class RouCollectionViewLayout<T: UICollectionViewCell>: UICollectionViewLayout {
    
    public typealias BlockTemplateHandle = ((_ cell: T?, _ index: Int) -> Void)
    
    //MARK: - 公共属性
    /** 列数 */
    public var columnNumber = 2
    /** 列间距 */
    public var interitemSpacing: CGFloat = 5.0
    /** 行间距 */
    public var lineSpacing: CGFloat = 5.0
    ///顶部和底部是否留距离
    public var topAndBottomSpacing = false
    
    //MARK: - 私有属性
    /// 所有的layoutAttribute
    private var arrLayoutAttributes: [UICollectionViewLayoutAttributes] = {
        return [UICollectionViewLayoutAttributes]()
    }()
    ///所有Item高度
    private var arrItemSize: [CGSize] = {
        return [CGSize]()
    }()
    private var arrColumn: [ColumnData] = {
        return [ColumnData]()
    }()
    private var templateCell: T?
    public var block: BlockTemplateHandle?
    
    private var itemWidth: CGFloat = 0
    private var insets: UIEdgeInsets!
    private var bounds: CGRect!
    
    public init(_ type: T.Type) {
        super.init()
        let name = "\(type)"
        templateCell = Bundle.main.loadNibNamed(name, owner: self, options: nil)?.last as? T
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func prepare() {
        super.prepare()
        
        bounds = self.collectionView?.bounds ?? CGRect.zero
        insets = self.collectionView?.contentInset ?? UIEdgeInsets.zero
        
        let contentWidth = bounds.size.width - insets.left - insets.right
        let column = CGFloat(columnNumber)
        itemWidth = (contentWidth - (column - 1) * interitemSpacing )/column
        
        self.calculateAttributesWithItemWidth(itemWidth)
    }
    
    /// 获取item的个数
    func itemCount(_ section: Int = 0) -> Int {
        guard let view = self.collectionView else {
            return 0
        }
        return view.dataSource?.collectionView(view, numberOfItemsInSection: section) ?? 0
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.arrLayoutAttributes
    }
    
    override open var collectionViewContentSize: CGSize {
        get {
            let data = maxColumn()
            let height = data.height + insets.bottom + (topAndBottomSpacing ? self.lineSpacing : 0)
            let width = bounds.size.width - insets.left - insets.right
            return CGSize(width: width, height: height)
        }
    }
    
    
}
//MARK: - 逻辑处理
public extension RouCollectionViewLayout {
    
    /// 根据宽度计算Attributes
    ///
    /// - Parameter width: 宽度
    func calculateAttributesWithItemWidth(_ width: CGFloat) {
        self.refreshLayoutCache()
        for index in 0..<itemCount() {
            self.block?(templateCell, index)
            let size = self.calculateSizeForCell(index, itemWidth, templateCell)
            let layoutAttributes = self.createLayoutAttributesWithItemSize(index, size)
            arrItemSize.append(size)
            arrLayoutAttributes.append(layoutAttributes)
        }
    }
    
    /// 根据大小和位置创建LayoutAttributes
    ///
    /// - Parameters:
    ///   - size: 大小
    ///   - index: 位置
    /// - Returns: LayoutAttributes
    func createLayoutAttributesWithItemSize( _ index: Int, _ size: CGSize) -> UICollectionViewLayoutAttributes {
        ///看看是否有必要设置成多section
        let layoutAttributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: index, section: 0))
        let data = minColumn()
        // x
        let itemX = (itemWidth + interitemSpacing) * (CGFloat(data.number))
        // y
        let spacing = (Int(index/columnNumber) == 0 && !topAndBottomSpacing) ? 0 : self.lineSpacing
        let itemY = data.height + spacing
        // size
        layoutAttributes.frame = CGRect(x: itemX, y: itemY, width: size.width, height: size.height)
        
        arrColumn[data.number].height = layoutAttributes.frame.maxY
        return layoutAttributes
    }
    
    /// 根据cell计算高度
    ///
    /// - Parameter cell: cell
    /// - Returns: 高度
    public func calculateSizeForCell(_ index: Int, _ width: CGFloat,_ cell: UICollectionViewCell?) -> CGSize {
        var size: CGSize?
        cell?.contentView.snp.remakeConstraints { (make) in
            make.width.equalTo(width)
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        size = cell?.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        return size ?? CGSize.zero
    }
    
    /// 刷新布局
    func refreshLayoutCache() {
        arrLayoutAttributes.removeAll()
        arrColumn.removeAll()
        arrItemSize.removeAll()
        for i in 0..<columnNumber {
            arrColumn.append(ColumnData(number: i, height: insets.top))
        }
    }
}

// MARK: - 排序
extension RouCollectionViewLayout {
    /// 最后一行所有列中最底部的一列，取最大的一个
    ///
    /// - Parameter arrHeight: 最后一行所有列位置
    /// - Returns: SPColumnInfo
    public func maxColumn() -> ColumnData {
        return self.sortCok(.asc)
    }
    
    /// 最后一行所有列中最顶部的一列，取最小的一个
    ///
    /// - Parameter arrHeight: 最后一行所有列位置
    /// - Returns: SPColumnInfo
    public func minColumn() -> ColumnData {
        return self.sortCok(.des)
    }
    
    private func sortCok(_ sort: SortEnum) -> ColumnData {
        let array = arrColumn.sorted(by: { (c1, c2) -> Bool in
            switch sort {
            case .asc:
                return c1.height > c2.height
            case .des:
                return c1.height < c2.height
            }
        })
        if array.count > 0 {
            return array[0]
        }
        return ColumnData()
    }
}
