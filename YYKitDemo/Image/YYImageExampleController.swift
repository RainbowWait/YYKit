//
//  YYImageExampleController.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/5.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class YYImageExampleController: UIViewController {
    
    @IBOutlet weak var listTable: UITableView!
    var dataArray = VCModel.initImageVCModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        print(self.view.frame)
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
extension YYImageExampleController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = model.title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let model = dataArray[indexPath.row]
        if let className = NSClassFromString(model.vcName) as? UIViewController.Type {
            self.navigationController?.pushViewController((className.init()), animated: true)
            
        }
        
    }
    
    
}
