//
//  MockService.swift
//  Guidomia
//
//  Created by michael.p.siapno on 11/13/21.
//

import Foundation

class MockService {
    static func guidomiaMockService(completion: @escaping (_ model: [GuidomiaModel]) -> Void) {
        if let path = Bundle.main.url(forResource: "GuidomiaMock", withExtension: "json") {
            do {
                let data:Data = try Data(contentsOf: path)
                let model = try JSONDecoder().decode([GuidomiaModel].self, from: data)
                print("ITEM:: \(model.first?.consList)")
                completion(model)
                return
            }
            catch {
                completion([])
                return
            }
        }
    }
}

