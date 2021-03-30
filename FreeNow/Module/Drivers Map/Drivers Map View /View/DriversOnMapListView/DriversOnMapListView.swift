//
//  DriversOnMapListView.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/30/21.
//

import UIKit

protocol DriversOnMapListViewDelegate: AnyObject {
    func driversOnMapListView(_ driversOnMapListView: DriversOnMapListView, didEndDisplayItemAt indexPath: IndexPath)
}

class DriversOnMapListView: UIView, NibLoadable {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerCell(withCellType: DriversOnMapListCollectionViewCell.self)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.collectionViewLayout = CardPagingLayout()
        }
    }
    
    // MARK: - Properties
    
    weak var delegate: DriversOnMapListViewDelegate?
    
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
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegate?.driversOnMapListView(self, didEndDisplayItemAt: indexPath)
    }
}
