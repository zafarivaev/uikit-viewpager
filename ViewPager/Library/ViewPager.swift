//
//  ViewPager.swift
//  ViewPager
//
//  Created by Zafar on 02/09/21.
//

import UIKit

class ViewPager: UIView {
    
    // MARK: - Initialization
    init(tabSizeConfiguration: TabbedView.SizeConfiguration) {
        self.sizeConfiguration = tabSizeConfiguration
        super.init(frame: .zero)
        
        self.setupUI()
        
        tabbedView.delegate =  self
        pagedView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public let sizeConfiguration: TabbedView.SizeConfiguration
    
    public lazy var tabbedView: TabbedView = {
        let tabbedView = TabbedView(
            sizeConfiguration: sizeConfiguration
        )
        return tabbedView
    }()
    
    public let pagedView = PagedView()
    
    // MARK: - UI Setup
    private func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tabbedView)
        self.addSubview(pagedView)
        
        NSLayoutConstraint.activate([
            tabbedView.leftAnchor
                .constraint(equalTo: self.leftAnchor),
            tabbedView.topAnchor
                .constraint(equalTo: self.topAnchor),
            tabbedView.rightAnchor
                .constraint(equalTo: self.rightAnchor),
            tabbedView.heightAnchor
                .constraint(equalToConstant: sizeConfiguration.height)
        ])
        
        NSLayoutConstraint.activate([
            pagedView.leftAnchor
                .constraint(equalTo: self.leftAnchor),
            pagedView.topAnchor
                .constraint(equalTo: self.tabbedView.bottomAnchor),
            pagedView.rightAnchor
                .constraint(equalTo: self.rightAnchor),
            pagedView.bottomAnchor
                .constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension ViewPager: TabbedViewDelegate {
    func didMoveToTab(at index: Int) {
        self.pagedView.moveToPage(at: index)
    }
}

extension  ViewPager: PagedViewDelegate {
    func didMoveToPage(index: Int) {
        self.tabbedView.moveToTab(at: index)
    }
}
