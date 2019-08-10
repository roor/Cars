//
//  LocalDataProvider.swift
//  Cars
//
//  Created by Artem Podustov on 8/10/19.
//  Copyright © 2019 podustov. All rights reserved.
//

import Foundation

protocol DataProvider {
    func loadItems<T: FileRepresentable>(type: T.Type, callback: @escaping ([T]) -> Void)
}

final class LocalDataProvider: DataProvider {
    let loadQueue: OperationQueue

    init() {
        loadQueue = OperationQueue()
        loadQueue.name = "cars.loadingFromFiles"
    }

    func loadItems<T>(type: T.Type, callback: @escaping ([T]) -> Void) where T: FileRepresentable {
        loadQueue.addOperation {
            guard let filePath = Bundle.main.path(forResource: T.fileName, ofType: "json") else {
                return
            }
            let url = URL(fileURLWithPath: filePath)
            let decoder = JSONDecoder()
            do {
                let data = try Data(contentsOf: url)
                let cars = try decoder.decode([T].self, from: data)

                OperationQueue.main.addOperation {
                    callback(cars)
                }
            } catch {
                print(error)
                OperationQueue.main.addOperation {
                    callback([])
                }
            }
        }
    }
}
