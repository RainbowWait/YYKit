//
//  CustomViewController.swift
//  YYKitDemo
//
//  Created by 郑小燕 on 2018/3/9.
//  Copyright © 2018年 郑小燕. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    var pageController: UIPageViewController!
    var viewControllers: [UIViewController] = [YYImageExampleController(), YYAnimatedImageController(), YYWebImageExample(), YYImageProgressiveExample(), CollectionViewController(), YYTextAttribute(), YYTextTagController(), YYTextAttachmentController(),  YYImageExampleController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = UIScreen.main.bounds
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.view.addSubview(pageController.view)
        pageController.view.frame = UIScreen.main.bounds
        self.addChildViewController(self.pageController)
        pageController.dataSource = self
        pageController.delegate = self
       pageController.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
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

extension CustomViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllers.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard viewControllers.count > previousIndex else {
            return nil
        }
        return viewControllers[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllers.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        let orderedViewViewControllerCout = viewControllers.count
        guard orderedViewViewControllerCout != nextIndex else {
           return nil
        }
        guard orderedViewViewControllerCout > nextIndex else {
           return nil
        }
        return viewControllers[nextIndex]
        
        
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
    }
    
}
