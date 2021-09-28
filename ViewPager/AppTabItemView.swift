//
//  AppTabItemView.swift
//  ViewPager
//
//  Created by Zafar on 14/09/21.
//

import UIKit

class AppTabItemView: UIView, TabItemProtocol {
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    private let title: String
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemOrange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func onSelected() {
        self.titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        if borderView.superview == nil {
            self.addSubview(borderView)
            
            NSLayoutConstraint.activate([
                borderView.leftAnchor.constraint(equalTo: self.leftAnchor),
                borderView.rightAnchor.constraint(equalTo: self.rightAnchor),
                borderView.heightAnchor.constraint(equalToConstant: 5),
                borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
    }
    
    func onNotSelected() {
        self.titleLabel.font = .systemFont(ofSize: 18)
        
        self.layer.shadowOpacity = 0
        
        self.borderView.removeFromSuperview()
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.backgroundColor = .systemBlue
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    
}
