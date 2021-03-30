//
//  DriverCardView.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/30/21.
//

import UIKit

class DriverCardView: UIView, NibLoadable {

    @IBOutlet weak var driverCodeLabel: UILabel!
    @IBOutlet weak var carTypeLabel: UILabel!
    @IBOutlet weak var driverStateLabel: UILabel!
    
    // MARK: - Life Cycle Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadNibContent()
    }
    
    // MARK: - Public Functions
    
    func configure(viewModel: DriverViewModel){
        driverCodeLabel.text = "\(viewModel.id)"
        carTypeLabel.text = viewModel.type
        driverStateLabel.text = viewModel.state
    }
}
