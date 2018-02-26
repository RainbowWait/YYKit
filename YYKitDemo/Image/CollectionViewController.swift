//
//  CollectionViewController.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/24.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import Alamofire

class CollectionViewController: UIViewController {
     var collection: UICollectionView!
    var activityModel: ActivityListModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.frame = UIScreen.main.bounds
        let flowlayout = RouCollectionViewLayout.init(CollectionViewCell.self)
//        let width: CGFloat = UIScreen.main.bounds.width
//                let width: CGFloat = (UIScreen.main.bounds.width - 10.0 * 2 - 5.0) / 2.0
//        let flowlayout = UICollectionViewFlowLayout()
//        flowlayout.estimatedItemSize = CGSize(width: width, height: 300)
//        flowlayout.minimumLineSpacing = 10
//        flowlayout.minimumInteritemSpacing = 5
//        flowlayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        
         collection = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowlayout)
        self.view.addSubview(collection)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor.white
//        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
//        collection.register(TestCell.self, forCellWithReuseIdentifier: "cell")
        self.loadData()
    
        

    }

    func loadData() {
        Alamofire.request("https://www.cqcb.com/api/get_activity.php?appkey=0b8484158dd39b9992f69779bab397ec&num=20&p=1&type=3&udid=0175d5bf68e918412fa4f5454a0245a3&userid=742540", method: .get).responseJSON { (response) in
            let object = ActivityListModel.deserialize(from:  String(data: response.data!, encoding: String.Encoding.utf8))
            self.activityModel = object
            self.collection.reloadData()
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.activityModel?.db?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!CollectionViewCell
        cell.model = self.activityModel?.db![indexPath.item]
        return cell
    }
    
    
}
