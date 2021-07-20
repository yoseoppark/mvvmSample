//
//  SecondViewController.swift
//  UTCTime
//
//  Created by YoseopPark on 2021/07/16.
//

import UIKit
import MLSCommon

class SecondViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        view.backgroundColor = .green
        tabBarController?.title = "두번째 화면"
        title = "리스트"
        
        print(Date().toYMDString())
    }
    
}
