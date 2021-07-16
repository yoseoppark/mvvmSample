//
//  MainTabBarController.swift
//  UTCTime
//
//  Created by YoseopPark on 2021/07/16.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTab()
    }
    
    func configureUI() {
        configureTab()
    }
    
    func configureTab() {
        self.viewControllers = [
            TimeViewController.init(viewModel: TimeViewModel.init()),
            SecondViewController.init()
        ]
    }
}
