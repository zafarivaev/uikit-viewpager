//
//  AppTabItemView.swift
//  ViewPager
//
//  Created by Zafar on 14/09/21.
//

import UIKit

class AppTabItemView: UIView, TabItemProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .lightGray
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func onSelected() {
        self.titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    func onNotSelected() {
        self.titleLabel.font = .systemFont(ofSize: 18)
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    
}
