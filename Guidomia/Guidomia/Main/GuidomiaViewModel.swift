//
//  ViewModel.swift
//  Guidomia
//
//  Created by michael.p.siapno on 11/13/21.
//

import Foundation
import RxSwift
import RxDataSources
import RxCocoa

class GuidomiaViewModel {
    
    let items: BehaviorRelay<[CarTableViewCell.CarItem]> = BehaviorRelay(value: [])
    
    required init(model: Any?) {
        
    }
    
    func loadData() {
        
        MockService.guidomiaMockService { model in
            
            if model.count > 0 {
                let data = model.sorted { $0.make < $1.make && $0.model > $1.model }
                var items: [CarTableViewCell.CarItem] = []
                data.forEach { item in
                    
                    guard let carType = CarTableViewCell.CarTypes(rawValue: item.make) else { return }
                    
                    items.append(CarTableViewCell.CarItem(image: carType == .none ? UIImage() : carType.image,
                                                          title: carType == .none ? item.model : carType.name,
                                                          subTitle: "Price: \(Double(item.customerPrice).formatAbreviation)",
                                                          rating: Double(item.rating)))
                }
                
                self.items.accept(items)
                
            }
            
        }
        
    }
    
}
