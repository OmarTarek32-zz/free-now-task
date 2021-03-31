//
//  DriversOnMapListView.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/30/21.
//

import UIKit

protocol DriversOnMapListViewDelegate: AnyObject {
    func driversOnMapListView(_ driversOnMapListView: DriversOnMapListView, didSelect driver: DriverViewModel, at indexPath: IndexPath)
}

class DriversOnMapListView: UIView, NibLoadable {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var topHeaderTitleView: UIView!
    @IBOutlet private weak var showHideLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerCell(withCellType: DriversOnMapListCollectionViewCell.self)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.collectionViewLayout = CardPagingLayout()
        }
    }
    
    // MARK: - Public Properties
    
    weak var delegate: DriversOnMapListViewDelegate?
    var didTapOnToggleView: (() -> Void)?
    
    // MARK: - Private Properties
    
    private var isShowen = false
    private var drivers: [DriverViewModel] = []
  
    // MARK: - Life Cycle Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadNibContent()
    }
    
    // MARK: - Public Functions
    
    func addDrivers(_ drivers: [DriverViewModel]) {
        self.drivers = drivers
        collectionView.reloadData()
        if !drivers.isEmpty {
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
        }
    }
    
    @IBAction private func toggoleViewVisabiltyAction(_ sender: UIButton) {
        didTapOnToggleView?()
        showHideLabel.text = isShowen ? "Show" : "Hide"
        isShowen.toggle()
    }
    
}

// MARK: - Extensions

extension DriversOnMapListView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        drivers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DriversOnMapListCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(viewModel: drivers[indexPath.row])
        return cell
    }
}

extension DriversOnMapListView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.driversOnMapListView(self, didSelect: drivers[indexPath.row], at: indexPath)
    }
}
