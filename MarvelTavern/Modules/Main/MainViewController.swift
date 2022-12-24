//
//  MainViewController.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let viewModel: MainViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    init(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
