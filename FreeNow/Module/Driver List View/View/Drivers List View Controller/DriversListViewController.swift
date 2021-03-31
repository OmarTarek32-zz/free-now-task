//
//  DriversListViewController.swift
//  FreeNow
//
//  Created by Omar Tarek on 3/27/21.
//

import UIKit

class DriversListViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerCell(withCellType: DriversListTableViewCell.self)
        }
    }
    
    // MARK: - Dependencies
    
    var interactor: DriversListViewToInteractorProtocol?
    
    // MARK: - Private Properties
    
    private var drivers: [DriverViewModel] = []
    private let cellHeight: CGFloat = 200
    
    // MARK: - Life Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // This delay is for giving the chance to the transaiton to be done be for loading data
        // it just kind of producing a beatuy UI nothing more, we can remove the delay and everything will work fine also
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.interactor?.fetchAllDriversInHambureg()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Extensions

extension DriversListViewController: DriversListViewProtocol {
    func showDriversList(_ drivers: [DriverViewModel]) {
        self.drivers = drivers
        tableView.reloadData()
    }
    
    func showErrorView(title: String, subTitle: String) {
        
    }
}

extension DriversListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        drivers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DriversListTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(viewModel: drivers[indexPath.row])
        return cell
    }
}

extension DriversListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
