//
//  TabbedView.swift
//  ViewPager
//
//  Created by Zafar on 02/09/21.
//

import UIKit

protocol TabbedViewDelegate: AnyObject {
    func didMoveToTab(at index: Int)
}

class TabbedView: UIView {
    
    enum SizeConfiguration {
        case fillProportionally(height: CGFloat)
        case fixed(width: CGFloat, height: CGFloat)
        case automatic
    }
    
    // MARK: - Lifecycle
    init(sizeConfiguration: SizeConfiguration,
         tabs: [TabItemProtocol] = []) {
        
        self.sizeConfiguration = sizeConfiguration
        self.tabs = tabs
        super.init(frame: .zero)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    weak var delegate: TabbedViewDelegate?
    
    public let sizeConfiguration: SizeConfiguration
    public var tabs: [TabItemProtocol] {
        didSet {
            self.collectionView.reloadData()
            self.tabs[currentlySelectedIndex].onSelected()
        }
    }
    private var currentlySelectedIndex: Int = 0
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .zero
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(TabCollectionViewCell.self, forCellWithReuseIdentifier: "TabCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints =  false
        return collectionView
    }()
    
    // MARK: - Action
    public func moveToTab(at index: Int) {
        self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
        
        self.tabs[currentlySelectedIndex].onNotSelected()
        self.tabs[index].onSelected()
        
        self.currentlySelectedIndex = index
    }
    
    // MARK: UI Setup
    private func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leftAnchor
                .constraint(equalTo: self.leftAnchor),
            collectionView.topAnchor
                .constraint(equalTo: self.topAnchor),
            collectionView.rightAnchor
                .constraint(equalTo: self.rightAnchor),
            collectionView.bottomAnchor
                .constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension TabbedView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch sizeConfiguration {
        case let .fillProportionally(height):
            let totalWidth = self.frame.width
            let widthPerItem = totalWidth / CGFloat(self.tabs.count)
            
            return CGSize(width: widthPerItem, height: height)
            
        case let .fixed(width, height):
            return CGSize(width: width, height: height)
        case .automatic:
            return tabs[indexPath.item].frame.size
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

extension TabbedView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabCollectionViewCell", for: indexPath) as! TabCollectionViewCell
        cell.view = tabs[indexPath.row]
        return cell
    }
}

extension TabbedView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.moveToTab(at: indexPath.item)
        self.delegate?.didMoveToTab(at: indexPath.item)
    }
}
