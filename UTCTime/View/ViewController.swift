//
//  ViewController.swift
//  UTCTime
//
//  Created by Chiwon Song on 2021/05/31.
//

import UIKit
import Combine

class ViewController: UIViewController {

    var datetimeLabel: UILabel! = {
        let label = UILabel.init()
        label.text = "Loading"
        label.textColor = .blue
        label.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
        return label
    }()
    
    var pastDayButton: UIButton = {
        let button = UIButton.init()
        button.setTitle("1일 전", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(onYesterday), for: .touchUpInside)
        return button
    }()
    
    var nextDayButton: UIButton = {
        let button = UIButton.init()
        button.setTitle("1일 후", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(onTomorrow), for: .touchUpInside)
        return button
    }()
    
    var refreshButton: UIButton = {
        let button = UIButton.init()
        button.setTitle("Refresh", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(onNow), for: .touchUpInside)
        return button
    }()
    
    var viewModel: ViewModel!
    
    private var bag = Set<AnyCancellable>()
    
    convenience init(viewModel: ViewModel) {
        self.init()
        defer {
            self.viewModel = viewModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        viewModel.$dateTimeString
            .compactMap{$0}
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: self.datetimeLabel)
            .store(in: &bag)
        
        viewModel.reload()
    }
    
    func configureUI() {
        
        title = "오늘의 시간"
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(datetimeLabel)
        view.addSubview(refreshButton)
        view.addSubview(pastDayButton)
        view.addSubview(nextDayButton)

        datetimeLabel.translatesAutoresizingMaskIntoConstraints = false
        datetimeLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20.0).isActive = true
        datetimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0).isActive = true
        datetimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
        datetimeLabel.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
                
        pastDayButton.translatesAutoresizingMaskIntoConstraints = false
        pastDayButton.topAnchor.constraint(equalTo: datetimeLabel.bottomAnchor, constant: 20.0).isActive = true
        pastDayButton.leadingAnchor.constraint(equalTo: datetimeLabel.leadingAnchor).isActive = true
        pastDayButton.trailingAnchor.constraint(equalTo: refreshButton.leadingAnchor, constant: -20.0).isActive = true
        pastDayButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.topAnchor.constraint(equalTo: datetimeLabel.bottomAnchor, constant: 20.0).isActive = true
        refreshButton.trailingAnchor.constraint(equalTo: nextDayButton.leadingAnchor, constant: -20.0).isActive = true
        refreshButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        nextDayButton.translatesAutoresizingMaskIntoConstraints = false
        nextDayButton.topAnchor.constraint(equalTo: datetimeLabel.bottomAnchor, constant: 20.0).isActive = true
        nextDayButton.trailingAnchor.constraint(equalTo: datetimeLabel.trailingAnchor).isActive = true
        nextDayButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        pastDayButton.widthAnchor.constraint(equalTo: refreshButton.widthAnchor).isActive = true
        refreshButton.widthAnchor.constraint(equalTo: nextDayButton.widthAnchor).isActive = true
        
    }
}

extension ViewController {
    
    @objc
    func onYesterday() {
        viewModel.moveDay(day: -1)
    }

    @objc
    func onNow() {
        viewModel.reload()
    }

    @objc
    func onTomorrow() {
        viewModel.moveDay(day: 1)
    }

}
