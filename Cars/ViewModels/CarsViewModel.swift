//
//  CarsViewModel.swift
//  Cars
//
//  Created by Artem Podustov on 8/10/19.
//  Copyright © 2019 podustov. All rights reserved.
//

import Foundation

protocol CarsViewModelDelegate: class {
    func didLoadCars(viewModel: CarsViewModel, cars: [CarToShow])
}

enum SortType {
    case price
    case name
}

final class CarsViewModel {

    weak var delegate: CarsViewModelDelegate?

    private(set) var dataProvider: DataProvider
    private var cars: [CarToShow] = []

    var sortBy: SortType = .price {
        didSet {
            let sortedCars = sort(cars: cars, with: sortBy)
            delegate?.didLoadCars(viewModel: self, cars: sortedCars)
        }
    }

    private let waitQueue = OperationQueue()

    init(dataProvider: DataProvider, delegate: CarsViewModelDelegate? = nil) {
        self.dataProvider = dataProvider
        self.delegate = delegate

        dataProvider.loadItems(type: Car.self) { (cars) in
            dataProvider.loadItems(type: Price.self) { (prices) in
                let carsToshow = cars.compactMap({ (car) -> CarToShow? in
                    let filtered = prices.filter { $0.id == car.id }
                    if let price = filtered.first {
                        return CarToShow(name: car.model, number: car.immatriculation, imageName: car.imageName, price: price.price)
                    }
                    return nil
                })
                self.cars = carsToshow

                let sortedCars = self.sort(cars: carsToshow, with: self.sortBy)
                self.delegate?.didLoadCars(viewModel: self, cars: sortedCars)
            }
        }

    }

    private func sort(cars: [CarToShow], with sortType: SortType) -> [CarToShow] {
        switch sortType {
        case .price:
            return cars.sorted { $0.price.decimalPrice() < $1.price.decimalPrice() }

        case .name:
            return cars.sorted { $0.name < $1.name }
        }
    }

    func price(for car: CarToShow, callback: @escaping (String?) -> Void) {
        waitQueue.addOperation {
            sleep(3)
            OperationQueue.main.addOperation {
                callback(car.price)
            }
        }
    }
}

class CarToShow: Showable {
    var name: String

    var number: String

    var imageName: String

    var price: String

    var priceIsShown: Bool = false

    init(name: String, number: String, imageName: String, price: String) {
        self.name = name
        self.imageName = imageName
        self.number = number
        self.price = price
    }
}
