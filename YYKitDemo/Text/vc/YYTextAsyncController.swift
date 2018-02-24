//
//  YYTextAsyncController.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/9.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class YYTextAsyncController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    var strings: [NSMutableAttributedString] = []
    var layouts: [YYTextLayout] = []
    var async: Bool! = true {
        didSet{
            for (index, cell) in self.listTableView.visibleCells.enumerated() {
                let cell = cell as! AsyncCell
                cell.async = async
                let indexPath = self.listTableView.indexPath(for: cell)
                if async {
                    cell.setAyncText(text: layouts[(indexPath?.row)!])
                } else {
                    cell.setAyncText(text: strings[(indexPath?.row)!])
                }
                
                
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.register(AsyncCell.self, forCellReuseIdentifier: "cell")
        
        for i in 0..<300 {
            let str = "\(i) Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫"
            let text = NSMutableAttributedString(string: str)
            text.font = UIFont.systemFont(ofSize: 10)
            text.lineSpacing = 0
            text.strokeWidth = -3
            text.strokeColor = UIColor.red
            text.lineHeightMultiple = 1
            text.maximumLineHeight = 12
            text.minimumLineHeight = 12
            let shadow = NSShadow()
            shadow.shadowBlurRadius = 1
            shadow.shadowColor = UIColor.red
            shadow.shadowOffset = CGSize(width: 0, height: 1)
            strings.append(text)
            let container = YYTextContainer(size: CGSize(width: YYScreenSize().width, height: 34))
            let layout = YYTextLayout(container: container, text: text)
            layouts.append(layout!)
            
            var toolbar = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
            toolbar.size = CGSize(width: YYScreenSize().width, height: 40)
            self.view.addSubview(toolbar)
            
//            let fps = YYFPSLabel
            
            
            
            
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
extension YYTextAsyncController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 34
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AsyncCell
        cell.async = self.async
        if async {
            cell.setAyncText(text: layouts[indexPath.row])
        } else {
            cell.setAyncText(text: strings[indexPath.row])
        }
        return cell
        
    }
    
    
}
