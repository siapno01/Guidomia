//
//  MockService.swift
//  Guidomia
//
//  Created by michael.p.siapno on 11/13/21.
//

import Foundation
import RealmSwift
import Differentiator

class MockService {
    static func guidomiaMockService(completion: @escaping (_ model: [GuidomiaModel]) -> Void) {
        if let path = Bundle.main.url(forResource: "GuidomiaMock", withExtension: "json") {
            do {
                let data:Data = try Data(contentsOf: path)
                let model = try JSONDecoder().decode([GuidomiaModel].self, from: data)
                print("ITEM:: \(model.first?.consList)")
                GuidomiaRealm.saveData(data: model)
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

class GuidomiaRealm: Object {
    public let consList = List<String>()
    @objc public dynamic var customerPrice: Int = 0
    @objc public dynamic var make: String = ""
    @objc public dynamic var marketPrice: Int = 0
    @objc public dynamic var model: String = ""
    public let prosList = List<String>()
    @objc public dynamic var rating: Int = 0
    
    static func saveData(data: [GuidomiaModel]) {
        
        var newRealmData: [GuidomiaRealm] = []
        
        data.forEach { item in
            let realmData = GuidomiaRealm()
            
            item.consList.forEach { stringValue in
                realmData.consList.append(stringValue)
            }
            
            item.prosList.forEach { stringValue in
                realmData.prosList.append(stringValue)
            }
            
            realmData.customerPrice = item.customerPrice
            realmData.make = item.make
            realmData.marketPrice = item.marketPrice
            realmData.model = item.model
            realmData.rating = item.rating
            
            newRealmData.append(realmData)
        }
        
        let realm = GuidomiaRealm.newRealm(for: "Guidomia")
        
        do {
            try realm.write { realm.add(newRealmData) }
        } catch let error {
            debugPrint(error)
        }
        
    }
    
    public static func newRealm(for domain: String) -> Realm {
        var configuration = Realm.Configuration.defaultConfiguration
        
        configuration.fileURL = Realm.Configuration.defaultConfiguration.fileURL?.deletingLastPathComponent().appendingPathComponent("\(domain).realm")
        
        configuration.deleteRealmIfMigrationNeeded = true
        
        return try! Realm(configuration: configuration)
    }
    
    public static func data() -> Results<GuidomiaRealm> {
        return newRealm(for: "Guidomia").objects(GuidomiaRealm.self)
    }
    
}
