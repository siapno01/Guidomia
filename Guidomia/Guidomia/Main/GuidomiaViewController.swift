//
//  ViewController.swift
//  Guidomia
//
//  Created by michael.p.siapno on 11/11/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class GuidomiaViewController: UIViewController {
    
    fileprivate struct LayoutConstraints {
        static let headerRatio: CGFloat = 212.0 / 375.0
    }
    
    typealias ViewModel = GuidomiaViewModel
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: UITableView.Style.grouped)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.estimatedRowHeight = 40
        view.rowHeight = UITableView.automaticDimension
        view.estimatedSectionFooterHeight = 150
        view.sectionHeaderHeight = UITableView.automaticDimension
        view.separatorStyle = .none
        view.contentInsetAdjustmentBehavior = .always
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.register(CarTableViewCell.self, forCellReuseIdentifier: CarTableViewCell.identifier)
        view.register(FilterHeaderViewCell.self, forHeaderFooterViewReuseIdentifier: FilterHeaderViewCell.identifier)
        return view
    }()
    
    let disposeBag = DisposeBag()
    
    let viewModel: ViewModel
    
    required init(model: Any?) {
        viewModel = ViewModel(model: model)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupView()
        setUpModelObservables()
        setupNav()
        viewModel.loadData()
    }
    
    fileprivate func setupView() {
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        setupHeaderView()
    }
    
    fileprivate func setupHeaderView() {
        
        let imgHeader: UIImageView = {
            let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.image = UIImage(named: "Tacoma")
            return view
        }()
        
        let title: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Tacoma 2021"
            label.textColor = .white
            label.font = UIFont(name: "Arial-BoldMT", size: 30)
            return label
        }()
        
        let subTitle: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Get your's now"
            label.textColor = .white
            label.font = UIFont(name: "Arial-BoldMT", size: 16)
            return label
        }()
        
        imgHeader.addSubview(title)
        imgHeader.addSubview(subTitle)
        
        tableView.tableHeaderView = imgHeader
        NSLayoutConstraint.activate([
            imgHeader.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            imgHeader.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 1),
            imgHeader.heightAnchor.constraint(equalTo: tableView.widthAnchor,
                                              multiplier: LayoutConstraints.headerRatio),
            imgHeader.topAnchor.constraint(equalTo: tableView.topAnchor),
            
            subTitle.bottomAnchor.constraint(equalTo: imgHeader.bottomAnchor, constant: -30),
            subTitle.leadingAnchor.constraint(equalTo: imgHeader.leadingAnchor, constant: 20),
            subTitle.trailingAnchor.constraint(equalTo: imgHeader.trailingAnchor, constant: -20),
            
            title.bottomAnchor.constraint(equalTo: subTitle.topAnchor),
            title.leadingAnchor.constraint(equalTo: imgHeader.leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: imgHeader.trailingAnchor, constant: -20)
        ])
        tableView.tableHeaderView?.layoutIfNeeded()
        tableView.tableHeaderView = imgHeader
        
    }

    fileprivate func setUpModelObservables() {
        
        let dataSource = RxTableViewSectionedReloadDataSource<GuidomiaViewModel.ModelContent>(
            configureCell: { _, tbl, indexPath, item in
                guard let cell = tbl.dequeueReusableCell(withIdentifier: CarTableViewCell.identifier) as? CarTableViewCell else {
                    return UITableViewCell()
                }
                cell.config(item: item)
                return cell
        })

        viewModel.modelContent.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel.didTap(idx: indexPath)
            }).disposed(by: disposeBag)
        
        
    }

    fileprivate func setupNav() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = AppColors.orange
        self.navigationController?.navigationBar.backgroundColor = AppColors.orange
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let labelItem = UILabel()
        labelItem.translatesAutoresizingMaskIntoConstraints = false
        labelItem.text = "GUIDOMIA"
        labelItem.textColor = .white
        labelItem.font = UIFont(name: "Georgia-Bold", size: 18)
        
        let menuItem = UIImageView()
        menuItem.translatesAutoresizingMaskIntoConstraints = false
        menuItem.contentMode = .scaleAspectFit
        menuItem.image = UIImage(named: "hamburger")
        
        let leftItem = UIBarButtonItem(customView: labelItem)
        let rightItem = UIBarButtonItem(customView: menuItem)
        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationItem.rightBarButtonItem = rightItem
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
}

// MARK: - Extensions

extension GuidomiaViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: FilterHeaderViewCell.identifier) as? FilterHeaderViewCell else {
            return UITableViewHeaderFooterView()
        }
        
        cell.makeTextField.rx.controlEvent([.editingChanged])
            .map({ cell.makeTextField })
            .asObservable()
            .subscribe(onNext: { textfield in
            
                let txtField = textfield.text ?? ""
                let modelTextField = cell.modelTextField.text ?? ""
                if txtField.isEmpty && modelTextField.isEmpty {
                    self.viewModel.loadData()
                } else {
                    let data = self.viewModel.savedItems
                    let filtered = data.filter { $0.make.contains(textfield.text ?? "")}.map { $0.make as String }
                    
                    cell.setupDropdown(anchorView: textfield, data: filtered) { itemSelected in
                        self.viewModel.loadData(type: .make, idx: section, text: itemSelected)
                    }
                }
                
            }).disposed(by: disposeBag)
        
        cell.modelTextField.rx.controlEvent([.editingChanged])
            .map({ cell.modelTextField })
            .asObservable()
            .subscribe(onNext: { textfield in
                
                let txtField = textfield.text ?? ""
                let makeTextField = cell.makeTextField.text ?? ""
                if txtField.isEmpty && makeTextField.isEmpty {
                    self.viewModel.loadData()
                } else {
                    let data = self.viewModel.savedItems
                    let filtered = data.filter { $0.model.contains(textfield.text ?? "")}.map { $0.model as String }
                    
                    cell.setupModelDropdown(anchorView: textfield, data: filtered) { itemSelected in
                        self.viewModel.loadData(type: .model, idx: section, text: itemSelected)
                    }
                }
                
            }).disposed(by: disposeBag)
        
        return cell
        
    }
    
}
