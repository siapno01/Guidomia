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
                
                data.enumerated().forEach { item in
                    
                    guard let carType = CarTableViewCell.CarTypes(rawValue: item.element.make) else { return }
                    
                    items.append(CarTableViewCell.CarItem(image: carType == .none ? UIImage() : carType.image,
                                                          title: carType == .none ? item.element.model : carType.name,
                                                          subTitle: "Price: \(Double(item.element.customerPrice).formatAbreviation)",
                                                          rating: Double(item.element.rating),
                                                          prosList: item.element.prosList,
                                                          consList: item.element.consList,
                                                          isExpandable: item.offset == 0 ? true : false))
                }
                
                self.items.accept(items)
                
            }
            
        }
        
    }
    
    func didTap(idx: IndexPath) {
        
        var newItem = self.items.value.map { CarTableViewCell.CarItem(image: $0.image,
                                                                      title: $0.title,
                                                                      subTitle: $0.subTitle,
                                                                      rating: $0.rating,
                                                                      prosList: $0.prosList,
                                                                      consList: $0.consList,
                                                                      isExpandable: false) }
        newItem[idx.row].isExpandable = true
        self.items.accept(newItem)
        
    }
    
}
