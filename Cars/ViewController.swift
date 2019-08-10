//
//  ViewController.swift
//  Cars
//
//  Created by Artem Podustov on 8/10/19.
//  Copyright © 2019 podustov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var cars: [CarToShow] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    var viewModel: CarsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let provider = LocalDataProvider()
        viewModel = CarsViewModel(dataProvider: provider, delegate: self)
    }

    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        viewModel.sortBy = sender.selectedSegmentIndex == 0 ? .price : .name
    }

}

extension ViewController: CarsViewModelDelegate {
    func didLoadCars(viewModel: CarsViewModel, cars: [CarToShow]) {
        self.cars = cars
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = cars[indexPath.row]
        if let carCell = cell as? TableViewCell {
            carCell.iconImageView.image = UIImage(named: item.imageName)
            carCell.modelLabel.text = item.name
            carCell.numberLabel.text = item.number
            carCell.priceLabel.text = item.price
            carCell.priceLabel.isHidden = !item.priceIsShown
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let cell = tableView.cellForRow(at: indexPath) as? TableViewCell, cell.priceLabel.isHidden {
            let item = cars[indexPath.row]
            cell.loadingIndicator.startAnimating()
            viewModel.price(for: item) { (price) in
                cell.loadingIndicator.stopAnimating()
                item.priceIsShown = true
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
}
