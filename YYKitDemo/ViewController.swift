//
//  ViewController.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/5.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class ViewController: UIViewController {
    @IBOutlet weak var ListTable: UITableView!
    let dataArray = VCModel.initModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "YYKit Example"
        self.ListTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        let model = dataArray[indexPath.row]
        cell.textLabel?.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataArray[indexPath.row]
        if let ClassName = NSClassFromString(model.vcName) as? UIViewController.Type {
    self.navigationController?.pushViewController(ClassName.init(), animated: true)
            
        }
    }
    
}

