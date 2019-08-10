//
//  CarViewModelTests.swift
//  CarsTests
//
//  Created by Artem Podustov on 8/10/19.
//  Copyright © 2019 podustov. All rights reserved.
//

import XCTest
@testable import Cars

class CarViewModelTests: XCTestCase {

    var delegate = MockDelegate()
    var sut: CarsViewModel!
    override func setUp() {
        let provider = MockDataProvider()
        sut = CarsViewModel(dataProvider: provider, delegate: delegate)
    }

    override func tearDown() {
        sut = nil
    }

    func testLoadCarsShouldReturn2() {
        XCTAssertEqual(delegate.cars.count, 2)
    }

    func testPriceForFirstCarShouldBe90000() {
        XCTAssertEqual(delegate.cars.first?.price, "90.000 Euro")
    }

    func testNameForFirstCarShouldBe1Model() {
        sut.sortBy = .name
        XCTAssertEqual(delegate.cars.first?.name, "1model")
    }
}

class MockDataProvider: DataProvider {
    let cars = [
        Car(id: 1, model: "2model", immatriculation: "HH"),
        Car(id: 2, model: "1model", immatriculation: "HH")]

    let prices = [
        Price(id: 1, price: "91.000 Euro"),
        Price(id: 2, price: "90.000 Euro")]
    func loadItems<T>(type: T.Type, callback: @escaping ([T]) -> Void) where T : FileRepresentable {
        if type is Car.Type {
            callback(cars as! [T])
        } else  if type is Price.Type {
            callback(prices as! [T])
        }
    }

}

class MockDelegate: CarsViewModelDelegate {
    var cars: [CarToShow] = []
    func didLoadCars(viewModel: CarsViewModel, cars: [CarToShow]) {
        self.cars = cars
    }


}
