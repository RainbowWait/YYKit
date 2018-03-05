//
//  CustomLayoutViewController.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/3/2.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import Alamofire

class CustomLayoutViewController: UIViewController {

    var colle: UICollectionView!
        var activityModel: ActivityListModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.frame = UIScreen.main.bounds
        let layout = CustomLayout()
        colle = UICollectionView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 100), collectionViewLayout: layout)
        self.view.addSubview(colle)
        self.colle.backgroundColor = UIColor.white
        colle.delegate = self
        colle.dataSource = self
        self.colle.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.loadData()
        

    }
    func loadData() {
        Alamofire.request("https://www.cqcb.com/api/get_activity.php?appkey=0b8484158dd39b9992f69779bab397ec&num=20&p=1&type=3&udid=0175d5bf68e918412fa4f5454a0245a3&userid=742540", method: .get).responseJSON { (response) in
            let object = ActivityListModel.deserialize(from:  String(data: response.data!, encoding: String.Encoding.utf8))
            self.activityModel = object
            self.colle.reloadData()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension CustomLayoutViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!CustomCollectionViewCell
        cell.model = self.activityModel?.db![indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
}
