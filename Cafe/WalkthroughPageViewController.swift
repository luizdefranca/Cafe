//
//  WalkthroughPageViewController.swift
//  Cafe
//
//  Created by Luiz on 11/11/19.
//  Copyright © 2019 Luiz. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var pageHeadings = ["First Page", "Second Page", "Third Page"]
    var pageImages = ["First Page", "Second Page", "Third Page"]
    var pageContens = ["First Page", "Second Page", "Third Page"]

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        index -= 1

        return contentViewController(at: index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        index += 1

        return contentViewController(at: index)
    }


    func contentViewController(at index: Int) -> ContentViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }

        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController {
            pageContentViewController.imageFile = pageHeadings[index]
            pageContentViewController.content = pageContens[index]
            pageContentViewController.heading = pageContens[index]
            return pageContentViewController
        }
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self

        if let startingViewController = contentViewController(at: 0){
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
            print("content pageview loaded")
        }

    }
    


}
