//
//  FilterTableViewCell.swift
//  Guidomia
//
//  Created by michael.p.siapno on 11/15/21.
//

import Foundation
import UIKit
import DropDown

class FilterHeaderViewCell: UITableViewHeaderFooterView {
    
    static let identifier = "FilterHeaderViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Filters"
        label.textColor = .white
        label.font = UIFont(name: "ArialMT", size: 18)
        return label
    }()
    
    let makeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Any make"
        textField.backgroundColor = .white
        textField.textColor = AppColors.bulletText
        textField.font = UIFont(name: "Arial-BoldMT", size: 14)
        return textField
    }()
    
    let modelTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Any model"
        textField.backgroundColor = .white
        textField.textColor = AppColors.bulletText
        textField.font = UIFont(name: "Arial-BoldMT", size: 14)
        return textField
    }()
    
    let makeTextfieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowColor = AppColors.bulletText.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 1.0
        return view
    }()
    
    let modelTextfieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowColor = AppColors.bulletText.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 1.0
        return view
    }()
    
    let makeDropDown: DropDown = {
        let view = DropDown()
        return view
    }()
    
    let modelDropDown: DropDown = {
        let view = DropDown()
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        let mainView = setupMainFilter()
        
        contentView.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
        
    }
    
    fileprivate func setupMainFilter() -> UIView {
        
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.darkGray
        view.layer.cornerRadius = 5
        
        let makeTextFieldView = setupTextFieldPadding(view: makeTextfieldView, txtField: makeTextField)
        let modelTextFieldView = setupTextFieldPadding(view: modelTextfieldView, txtField: modelTextField)
        
        view.addSubview(titleLabel)
        view.addSubview(makeTextFieldView)
        view.addSubview(modelTextFieldView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            makeTextFieldView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            makeTextFieldView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            makeTextFieldView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            modelTextFieldView.topAnchor.constraint(equalTo: makeTextFieldView.bottomAnchor, constant: 15),
            modelTextFieldView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            modelTextFieldView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            modelTextFieldView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
        
        return view
    }
    
    fileprivate func setupTextFieldPadding(view: UIView, txtField: UITextField) -> UIView {
        
        view.addSubview(txtField)
        
        NSLayoutConstraint.activate([
            txtField.topAnchor.constraint(equalTo: view.topAnchor, constant: 6),
            txtField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            txtField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            txtField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -6),
        ])
        
        return view
        
    }
    
    func setupDropdown(anchorView: UIView, data: [String], completion: @escaping (_ itemSelected: String) -> Void) {
        
        makeDropDown.anchorView = anchorView
        makeDropDown.direction = .bottom
        makeDropDown.dataSource = data
        makeDropDown.bottomOffset = CGPoint(x: 0, y:(makeDropDown.anchorView?.plainView.bounds.height)!)
        makeDropDown.show()
        
        makeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            makeTextField.text = item
            completion(item)
        }
        
    }
    
    func setupModelDropdown(anchorView: UIView, data: [String], completion: @escaping (_ itemSelected: String) -> Void) {
        
        modelDropDown.anchorView = anchorView
        modelDropDown.direction = .bottom
        modelDropDown.dataSource = data
        modelDropDown.bottomOffset = CGPoint(x: 0, y:(modelDropDown.anchorView?.plainView.bounds.height)!)
        modelDropDown.show()
        
        modelDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            modelTextField.text = item
            completion(item)
        }
        
    }
    
}
