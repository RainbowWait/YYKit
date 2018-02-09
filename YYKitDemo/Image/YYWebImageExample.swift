//
//  YYWebImageExample.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/2/6.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit
import YYKit

class YYWebImageExample: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "\(YYWebImageExample.self)", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var listTableView: UITableView!
    let links: [String] = ["https://s-media-cache-ak0.pinimg.com/1200x/2e/0c/c5/2e0cc5d86e7b7cd42af225c29f21c37f.jpg",
        "http://i.imgur.com/uoBwCLj.gif",
        "http://i.imgur.com/8KHKhxI.gif",
        "http://i.imgur.com/WXJaqof.gif",
        "https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1780193/dots18.gif",
        "https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1809343/dots17.1.gif",
        "https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1845612/dots22.gif",
        "https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1820014/big-hero-6.gif",
        "https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1819006/dots11.0.gif",
        "https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1799885/dots21.gif",
       "https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/2025999/batman-beyond-the-rain.gif",
       "https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1855350/r_nin.gif",
       "https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1963497/way-back-home.gif",
       "https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1913272/depressed-slurp-cycle.gif",
       "https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/2047158/beerhenge.jpg",
       "https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/2016158/avalanche.jpg",
       "https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1839353/pilsner.jpg",
       "https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1833469/porter.jpg",
       "https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1521183/farmers.jpg",
       "https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1391053/tents.jpg",
       "https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1399501/imperial_beer.jpg",
       "https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1488711/fishin.jpg",
       "https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1466318/getaway.jpg",
       "http://littlesvr.ca/apng/images/BladeRunner.png",
       "http://littlesvr.ca/apng/images/Contact.webp"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = UIScreen.main.bounds
        print(self.view.frame)
        listTableView.separatorStyle = .none
        let button = UIBarButtonItem(title: "Reload", style: .plain, target: self, action: #selector(reload))
        self.listTableView.backgroundColor = UIColor.clear
        self.navigationItem.rightBarButtonItem = button
        self.view.backgroundColor = UIColor(white: 0.217, alpha: 1.0)
        self.listTableView.register(YYWebImageExampleCell.self, forCellReuseIdentifier: "cell")
        self.listTableView.reloadData()
        self.scrollViewDidScroll(self.listTableView)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = nil
        UIApplication.shared.statusBarStyle = .default
        
    }
    
    @objc func reload() {
        YYImageCache.shared().memoryCache.removeAllObjects()
        YYImageCache.shared().diskCache.removeAllObjects()
        self.listTableView.perform(#selector(reloadData), afterDelay: 0.1)
    
    }
    @objc func reloadData() {
        
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

extension YYWebImageExample: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return links.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (YYScreenSize().width * 3.0 / 4)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! YYWebImageExampleCell
        cell.setImageUrl(url: URL(string: links[indexPath.row])!)
        return cell
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let viewHeight = scrollView.height + scrollView.contentInset.top
        for cell in self.listTableView.visibleCells {
            let cell = cell as! YYWebImageExampleCell
            let y = cell.centerY - scrollView.contentOffset.y
            let p = y - viewHeight / 2
            let scale = cos(p / viewHeight * 0.8) * 0.95
            
            UIView.animate(withDuration: 0.15, delay: 0, options: [UIViewAnimationOptions.curveEaseOut, .allowUserInteraction, .beginFromCurrentState], animations: {
                cell.webImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            }, completion: nil)
            
            
        }
        
    }
    
    
}
