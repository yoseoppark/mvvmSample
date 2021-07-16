//
//  TimeViewController.swift
//  UTCTime
//
//  Created by Chiwon Song on 2021/05/31.
//

import UIKit
import Combine
import SnapKit

class TimeViewController: UIViewController {

    var datetimeLabel: UILabel = {
        let label = UILabel.init()
        label.text = "Loading"
        label.textColor = .black
        label.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    var pastDayButton: UIButton = {
        let button = UIButton.init()
        button.setTitle("1일 전", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(onYesterday), for: .touchUpInside)
        button.layer.cornerRadius = 10.0
        return button
    }()

    var refreshButton: UIButton = {
        let button = UIButton.init()
        button.setTitle("Refresh", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(onNow), for: .touchUpInside)
        button.layer.cornerRadius = 10.0
        return button
    }()
    
    var nextDayButton: UIButton = {
        let button = UIButton.init()
        button.setTitle("1일 후", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(onTomorrow), for: .touchUpInside)
        button.layer.cornerRadius = 10.0
        return button
    }()
    
    var viewModel: TimeViewModel!
    
    private var bag = Set<AnyCancellable>()
    
    convenience init(viewModel: TimeViewModel) {
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
        
        datetimeLabel.snp.makeConstraints { label in
            label.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            label.leading.equalTo(view.snp.leading).offset(20.0)
            label.trailing.equalTo(view.snp.trailing).offset(-20.0)
            label.height.equalTo(60.0)
        }
        
        pastDayButton.snp.makeConstraints { button in
            button.top.equalTo(datetimeLabel.snp.bottom).offset(20.0)
            button.leading.equalTo(datetimeLabel.snp.leading)
            button.trailing.equalTo(refreshButton.snp.leading).offset(-20.0)
            button.height.equalTo(40.0)
            button.width.equalTo(refreshButton.snp.width)
        }
                
        refreshButton.snp.makeConstraints { button in
            button.top.equalTo(datetimeLabel.snp.bottom).offset(20.0)
            button.trailing.equalTo(nextDayButton.snp.leading).offset(-20.0)
            button.height.equalTo(40.0)
            button.width.equalTo(nextDayButton.snp.width)
        }
        
        nextDayButton.snp.makeConstraints { button in
            button.top.equalTo(datetimeLabel.snp.bottom).offset(20.0)
            button.trailing.equalTo(datetimeLabel.snp.trailing)
            button.height.equalTo(40.0)
        }
        
//        refreshButton.translatesAutoresizingMaskIntoConstraints = false
//        refreshButton.topAnchor.constraint(equalTo: datetimeLabel.bottomAnchor, constant: 20.0).isActive = true
//        refreshButton.trailingAnchor.constraint(equalTo: nextDayButton.leadingAnchor, constant: -20.0).isActive = true
//        refreshButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true

//        nextDayButton.translatesAutoresizingMaskIntoConstraints = false
//        nextDayButton.topAnchor.constraint(equalTo: datetimeLabel.bottomAnchor, constant: 20.0).isActive = true
//        nextDayButton.trailingAnchor.constraint(equalTo: datetimeLabel.trailingAnchor).isActive = true
//        nextDayButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true

//        pastDayButton.widthAnchor.constraint(equalTo: refreshButton.widthAnchor).isActive = true
//        refreshButton.widthAnchor.constraint(equalTo: nextDayButton.widthAnchor).isActive = true
        
    }
}

extension TimeViewController {
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
