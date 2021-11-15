//
//  CarTableViewCell.swift
//  Guidomia
//
//  Created by michael.p.siapno on 11/13/21.
//

//import Foundation
import UIKit
import Cosmos

class CarTableViewCell: UITableViewCell {
    
    static let identifier = "CarTableViewCell"
    
    struct CarItem: Hashable {
        let image: UIImage?
        let title: String
        let subTitle: String
        let rating: Double
        let prosList: [String]
        let consList: [String]
        let make: String
        let model: String
        var isExpandable: Bool = false
        
        static func == (lhs: CarItem, rhs: CarItem) -> Bool {
            return lhs.model == rhs.model && lhs.make == rhs.make
        }
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
        view.settings.updateOnTouch = false
        return view
    }()
    
    let consLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cons: "
        label.textColor = AppColors.textBlack
        label.font = UIFont(name: "Arial-BoldMT", size: 14)
        return label
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 10
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    let prosStackVIew: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    let consStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.orange
        return view
    }()
    
    let bullet = "\u{2022}"
    
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
            setupLineView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        stackView.addArrangedSubview(mainView)
        
    }
    
    func config(item: CarTableViewCell.CarItem) {
        carImage.image = item.image
        title.text = item.title
        subTitle.text = item.subTitle
        cosmos.rating = item.rating
        
        if item.prosList.count != 0 {
            prosStackVIew.removeAllArrangedSubviews()
            prosStackVIew.removeFromSuperview()
            setupExpandableDetails(title: "Pros", desc: item.prosList, mainStack: prosStackVIew)
            stackView.addArrangedSubview(prosStackVIew)
        }
        
        if item.consList.count != 0 {
            consStackView.removeAllArrangedSubviews()
            consStackView.removeFromSuperview()
            setupExpandableDetails(title: "Cons", desc: item.consList, mainStack: consStackView)
            stackView.addArrangedSubview(consStackView)
        }
        
        prosStackVIew.isHidden = item.isExpandable ? false : true
        consStackView.isHidden = item.isExpandable ? false : true
        
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
        
        NSLayoutConstraint.activate([
            carImage.widthAnchor.constraint(equalToConstant: 120),
            carImage.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        return stack
    }
    
    fileprivate func setupLineView() -> UIView {
        
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
    
    fileprivate func setupExpandableDetails(title: String, desc: [String], mainStack: UIStackView) {
        let titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "\(title) :"
            label.textColor = AppColors.textBlack
            label.font = UIFont(name: "Arial-BoldMT", size: 16)
            return label
        }()
        
        let stack: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fill
            stack.spacing = 5
            stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10)
            stack.isLayoutMarginsRelativeArrangement = true
            return stack
        }()
        
        mainStack.addArrangedSubview(titleLabel)
        
        desc.forEach { item in
            
            guard !item.isEmpty else { return }
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "\(bullet) \(item)"
            label.textColor = AppColors.bulletText
            label.font = UIFont(name: "Arial-BoldMT", size: 14)
            setContent(label: label)
            stack.addArrangedSubview(label)
        }
        
        mainStack.addArrangedSubview(stack)
    }
    
    func setContent(label: UILabel) {
        
        let appFont = label.font ?? UIFont.systemFont(ofSize: 14)
        let font = UIFontMetrics.default.scaledFont(for: appFont)
        let fontSize = font.pointSize
        let lineHeight: CGFloat = 14.0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight - fontSize
        
        let attributedString =  NSMutableAttributedString(string: label.text ?? "",
            attributes: [NSAttributedString.Key.font: font,
                         NSAttributedString.Key.foregroundColor: label.textColor ?? AppColors.bulletText])
        
        let range = NSRange(location: 0, length: attributedString.length)
        
        attributedString.addAttribute(.paragraphStyle,
                                           value: paragraphStyle,
                                           range: range)
        
        let bulletRange = attributedString.mutableString.range(of: bullet)
        attributedString.addAttributes([NSAttributedString.Key.font: font.withSize(16),
                                        NSAttributedString.Key.foregroundColor: AppColors.orange], range: bulletRange)
        
        label.attributedText = attributedString
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        prosStackVIew.removeAllArrangedSubviews()
        consStackView.removeAllArrangedSubviews()
        prosStackVIew.removeFromSuperview()
        consStackView.removeFromSuperview()
    }
    
}
