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
         collection = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowlayout)
        self.view.addSubview(collection)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor.white
        collection.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!CollectionViewCell
        cell.backgroundColor = UIColor.red
        cell.model = self.activityModel?.db![indexPath.item]
        return cell
    }
    
    
}
