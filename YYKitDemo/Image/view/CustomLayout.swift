//
//  CustomLayout.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/24.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit



class CustomLayout: UICollectionViewLayout {
    
    var attrArr: [UICollectionViewLayoutAttributes] = []
    
    let itmeWidth: CGFloat = 40
    let intersectionWidth: CGFloat = 10
    
    override func prepare() {
       super.prepare()
        self.attrArr.removeAll()
        self.createAttribute()
    }
    
    func createAttribute() {
        let count = self.collectionView?.numberOfItems(inSection: 0)
        for i in 0..<count! {
            let indexPath = IndexPath(item: i, section: 0)
            let attrs = self.layoutAttributesForItem(at: indexPath)
            self.attrArr.append(attrs!)
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attrArr
        
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let count = self.collectionView?.numberOfItems(inSection: 0)
        let width = self.collectionView?.frame.width
        let y = (self.collectionView?.frame.height)! / 2.0
        let attriX = (width! - (itmeWidth + CGFloat(count! - 1) * (itmeWidth - intersectionWidth))) / 2 + (itmeWidth - intersectionWidth) * CGFloat(indexPath.row) + CGFloat(2 * indexPath.row)
        let attr = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        attr.center = CGPoint(x: attriX, y: y)
        attr.size = CGSize(width: itmeWidth, height: itmeWidth)
        return attr
    
    }
}

