//
//  WalkthroughPageViewController.swift
//  Cafe
//
//  Created by Luiz on 11/11/19.
//  Copyright © 2019 Luiz. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    //MARK: - Properties
    var pageHeadings = ["First Page", "Second Page", "Third Page"]
    var pageImages = ["firstScreen", "secondScreen", "thirdScreen"]
    var pageContens = ["Firs Page", "Second Page", "Third Page"]


    //MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self

        if let startingViewController = contentViewController(at: 0){
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
            print("content pageview loaded")
        }

    }

    //MARK: - Functions

    func contentViewController(at index: Int) -> ContentViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }

        let storyboard = UIStoryboard(name: "ContentPageView", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController {
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.content = pageContens[index]
            pageContentViewController.heading = pageContens[index]
            pageContentViewController.index = index
            return pageContentViewController
        }
        return nil
    }


    func forward(for index: Int){
        if let nextViewController = contentViewController(at: index + 1) {
            
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    //MARK: - UIPageViewControllerDataSource   Methods
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


/*
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageHeadings.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        let storyboard = UIStoryboard(name: "ContentPageView", bundle: nil  )
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController {
            return pageContentViewController.index
        }
        return 0
    }

*/


}
