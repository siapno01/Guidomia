//
//  CarTableViewCell.swift
//  Guidomia
//
//  Created by michael.p.siapno on 11/13/21.
//

import Foundation
import UIKit
import Cosmos

class CarTableViewCell: UITableViewCell {
    
    static let identifier = "CarTableViewCell"
    
    struct CarItem {
        let image: UIImage?
        let title: String
        let subTitle: String
        let rating: Double
    }
    
    enum CarTypes: String {
        case landRover = "Land Rover"
        case alpine = "Alpine"
        case bmw = "BMW"
        case mercedesBenz = "Mercedes Benz"
        case none
        
        var name: String {
            switch self {
            
            case .landRover:
                return "Range Rover"
            case .alpine:
                return "Alphine roadster"
            case .bmw:
                return "BMW 3300i"
            case .mercedesBenz:
                return "Mercedes Benz"
            case .none:
                return ""
            }
        }
        
        var image: UIImage? {
            switch self {
            
            case .landRover:
                return UIImage(named: "Range_Rover")
            case .alpine:
                return UIImage(named: "Alpine_roadster")
            case .bmw:
                return UIImage(named: "BMW_330i")
            case .mercedesBenz:
                return UIImage(named: "Mercedez_benz_GLC")
            case .none:
                return UIImage()
            }
        }
    }
    
    let carImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Alpine_roadster")
        return imageView
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Alphine roadster"
        label.textColor = AppColors.textBlack
        label.font = UIFont(name: "Arial-BoldMT", size: 20)
        return label
    }()
    
    let subTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Price : 65k"
        label.textColor = AppColors.textBlack
        label.font = UIFont(name: "Arial-BoldMT", size: 14)
        return label
    }()
    
    let cosmos: CosmosView = {
        let view = CosmosView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.rating = 5
        view.settings.filledImage = UIImage(named: "filled_star_icon")
        view.settings.emptyImage = UIImage(named: "empty_star_icon")
        view.settings.starMargin = 5
        view.settings.starSize = 20
        return view
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.orange
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        
        contentView.backgroundColor = AppColors.lightGray
        
        let mainView = setupMainView()
        let setupLineView = setupLineView()
        
        contentView.addSubview(stackView)
        contentView.addSubview(setupLineView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            setupLineView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            setupLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            setupLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            setupLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            setupLineView.heightAnchor.constraint(equalToConstant: 20),
            carImage.widthAnchor.constraint(equalToConstant: 120),
            carImage.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        stackView.addArrangedSubview(mainView)
        
    }
    
    func config(item: CarTableViewCell.CarItem) {
        carImage.image = item.image
        title.text = item.title
        subTitle.text = item.subTitle
        cosmos.rating = item.rating
    }
    
    fileprivate func setupDetails() -> UIStackView {
        
        let stack: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fill
            return stack
        }()
        
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(subTitle)
        stack.addArrangedSubview(UIView())
        stack.addArrangedSubview(cosmos)
        
        return stack
    }
    
    fileprivate func setupMainView() -> UIStackView{
        
        let stack: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .fill
            stack.spacing = 20
            return stack
        }()
        
        let setupDetails = setupDetails()
        
        stack.addArrangedSubview(carImage)
        stack.addArrangedSubview(setupDetails)
        
        return stack
    }
    
    func setupLineView() -> UIView {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
    
        view.addSubview(lineView)
        
        NSLayoutConstraint.activate([
            lineView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            lineView.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        return view
    }
    
}
