//
//  DriversOnMapListCollectionViewCell.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/30/21.
//

import UIKit

class DriversOnMapListCollectionViewCell: UICollectionViewCell, Reuseable {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var driverCardView: DriverCardView!
    
    // MARK: - Life Cycle Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateTheme()
    }
    
    // MARK: - Public Functions
    
    func configure(viewModel: DriverViewModel){
        driverCardView.configure(viewModel: viewModel)
    }
    
    // MARK: - Private Functions
    func updateTheme() {
        driverCardView.layer.cornerRadius = 16
    }
}
