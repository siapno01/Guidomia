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


extension GuidomiaViewModel.ModelContent: SectionModelType {
    typealias Item = CarTableViewCell.CarItem
    
    init(original: GuidomiaViewModel.ModelContent, items: [Item]) {
        self = original
        self.items = items
    }
    
}

class GuidomiaViewModel {

    enum LoadDataType {
        case make
        case model
    }
    
    struct SearchedItem {
        let type: LoadDataType
        let item: CarTableViewCell.CarItem
    }
    
    struct ModelContent {
        var items: [CarTableViewCell.CarItem]
    }
    
    let modelContent: BehaviorRelay<[ModelContent]> = BehaviorRelay(value: [])
    var savedItems: [CarTableViewCell.CarItem] = []
    var searchedItems: [SearchedItem] = []
    required init(model: Any?) {
        
    }
    
    func loadData() {
        
        MockService.guidomiaMockService { model in
            
            if model.count > 0 {
                let data = model.sorted { $0.make < $1.make && $0.model > $1.model }
                
                var carItems: [CarTableViewCell.CarItem] = []
                
                data.enumerated().forEach { item in
                    
                    guard let carType = CarTableViewCell.CarTypes(rawValue: item.element.make) else { return }
                
                    let carItem = CarTableViewCell.CarItem(image: carType == .none ? UIImage() : carType.image,
                                                           title: carType == .none ? item.element.model : carType.name,
                                                           subTitle: "Price: \(Double(item.element.customerPrice).formatAbreviation)",
                                                           rating: Double(item.element.rating),
                                                           prosList: item.element.prosList,
                                                           consList: item.element.consList,
                                                           make: item.element.make,
                                                           model: item.element.model,
                                                           isExpandable: item.offset == 0 ? true : false)
                    
                    carItems.append(carItem)
                    
                }
                self.savedItems = carItems
                self.modelContent.accept([ModelContent(items: carItems)])
            }
            
        }
        
    }
    
    func didTap(idx: IndexPath) {
        
        var newItem = self.modelContent.value[idx.section].items.map { CarTableViewCell.CarItem(image: $0.image,
                                                                                                title: $0.title,
                                                                                                subTitle: $0.subTitle,
                                                                                                rating: $0.rating,
                                                                                                prosList: $0.prosList,
                                                                                                consList: $0.consList,
                                                                                                make: $0.make,
                                                                                                model: $0.model,
                                                                                                isExpandable: false) }
        
        newItem[idx.row].isExpandable = true
        self.modelContent.accept([ModelContent(items: newItem)])
        
    }
    
    func loadData(type: LoadDataType, idx: Int, text: String) {
        
        switch type {
        case .make:
            var filteredSearched = self.searchedItems.filter { $0.type == .model }
            savedItems.filter { $0.make.contains(text)}
            .forEach { filteredSearched.append(SearchedItem(type: .make, item: $0)) }
            
            let items = filteredSearched.map { $0.item }
            
            let unique = Array(Set(items.compactMap { CarTableViewCell.CarItem(image: $0.image,
                                                                               title: $0.title,
                                                                               subTitle: $0.subTitle,
                                                                               rating: $0.rating,
                                                                               prosList: $0.prosList,
                                                                               consList: $0.consList,
                                                                               make: $0.make,
                                                                               model: $0.model) } ))
            
            self.searchedItems = filteredSearched
            self.modelContent.accept([ModelContent(items: unique)])
        case .model:
            var filteredSearched = self.searchedItems.filter { $0.type == .make }
            savedItems.filter { $0.model.contains(text)}
            .forEach { filteredSearched.append(SearchedItem(type: .model, item: $0)) }
            
            let items = filteredSearched.map { $0.item }
            
            let unique = Array(Set(items.compactMap { CarTableViewCell.CarItem(image: $0.image,
                                                                               title: $0.title,
                                                                               subTitle: $0.subTitle,
                                                                               rating: $0.rating,
                                                                               prosList: $0.prosList,
                                                                               consList: $0.consList,
                                                                               make: $0.make,
                                                                               model: $0.model) } ))
        
            self.searchedItems = filteredSearched
            self.modelContent.accept([ModelContent(items: unique)])
        }
    }
    
}
