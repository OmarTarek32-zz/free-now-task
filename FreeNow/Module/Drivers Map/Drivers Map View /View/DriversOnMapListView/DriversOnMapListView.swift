//
//  DriversOnMapListView.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/30/21.
//

import UIKit

class DriversOnMapListView: UIView, NibLoadable {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerCell(withCellType: DriversOnMapListCollectionViewCell.self)
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    // MARK: - Properties
    
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

extension DriversOnMapListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: frame.width - (frame.width * 0.1) , height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

}

extension DriversOnMapListView: UICollectionViewDelegate {
    
}
