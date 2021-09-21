//
//  ViewController.swift
//  ViewPager
//
//  Created by Zafar on 14/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.overrideUserInterfaceStyle = .light
        self.view.backgroundColor = .white
        self.view.addSubview(viewPager)
        
        NSLayoutConstraint.activate([
            viewPager.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            viewPager.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7),
            viewPager.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            viewPager.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    lazy var viewPager: ViewPager = {
        let viewPager = ViewPager(tabHeight: 60)
        viewPager.tabbedView.tabs = [AppTabItemView(), AppTabItemView(), AppTabItemView()]
        viewPager.pagedView.pages = [UIView(), UIView(), UIView()]
        viewPager.translatesAutoresizingMaskIntoConstraints = false
        return viewPager
    }()
}
