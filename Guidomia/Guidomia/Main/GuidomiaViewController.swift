//
//  ViewController.swift
//  Guidomia
//
//  Created by michael.p.siapno on 11/11/21.
//

import UIKit

class GuidomiaViewController: UIViewController {
    typealias ViewModel = GuidomiaViewModel
    
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
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }


}

