//
//  ErrorView.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/31/21.
//

import UIKit

class ErrorView: UIView, NibLoadable {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var retryButton: UIButton!
    
    // MARK: - Properties
    
    private var onRetry: (() -> Void)?
    
    // MARK: - Life Cycle Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupTheme()
    }
    
    // MARK: - Functions
    
    func setupTheme() {
        retryButton.layer.cornerRadius = 8
        retryButton.isHidden = true
    }
    
    func configure(title: String = "Oops something went wrong!", subtitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subtitle
    }
    
    func onRetry(_ compeletion: @escaping () -> Void) {
        onRetry = compeletion
        retryButton.isHidden = false
    }
    
    // MARK: - Actions
    
    @IBAction private func retryButtonTapped(_ sender: UIButton) {
        onRetry?()
    }
}
