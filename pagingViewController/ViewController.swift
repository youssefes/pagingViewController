//
//  ViewController.swift
//  pagingViewController
//
//  Created by youssef on 10/13/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    lazy var view0 : UIView = {
        let view = UIView()
        view.backgroundColor = .systemTeal
        let label = UILabel()
        label.text = "Page 0"
        label.textAlignment = .center
        view.addSubview(label)
        label.edgeTo(view: view)
        return view
    }()
    
    lazy var view1 : UIView = {
         let view = UIView()
         view.backgroundColor = .systemYellow
         let label = UILabel()
         label.text = "Page 1"
         label.textAlignment = .center
         view.addSubview(label)
         label.edgeTo(view: view)
         return view
     }()
    
    lazy var view2 : UIView = {
         let view = UIView()
         view.backgroundColor = .systemPink
         let label = UILabel()
         label.text = "Page 2"
         label.textAlignment = .center
         view.addSubview(label)
         label.edgeTo(view: view)
         return view
     }()
    
    lazy var views = [view0,view1,view2]
    
    lazy var scrollview : UIScrollView = {
        let scrollview = UIScrollView()
        
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.isPagingEnabled = true
        scrollview.contentSize = CGSize(width: view.frame.width * CGFloat(views.count), height: view.frame.height)
        for i in 0 ..< views.count{
            scrollview.addSubview(views[i])
            views[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
        }
        
        scrollview.delegate = self
        return scrollview
    }()
    
    lazy var pageController : UIPageControl = {
        let pagecontrol = UIPageControl()
        pagecontrol.numberOfPages = views.count
        pagecontrol.currentPage = 0
        pagecontrol.addTarget(self, action: #selector(pagecontroltapHandler(sender:)), for: .touchUpInside)
        return pagecontrol
    }()
    
   @objc func pagecontroltapHandler(sender: UIPageControl) {
    scrollview.scrollTo(horizontalPage: sender.currentPage, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollview)
        scrollview.edgeTo(view: view)
        
        view.addSubview(pageController)
        pageController.pinTo(view)
    }


}

extension ViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageindex = round(scrollView.contentOffset.x / view.frame.width)
        
        pageController.currentPage = Int(pageindex)
    }
}

