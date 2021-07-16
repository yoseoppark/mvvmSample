//
//  TimeViewModel.swift
//  UTCTime
//
//  Created by Chiwon Song on 2021/05/31.
//

import Combine

class TimeViewModel {
    
    @Published var dateTimeString = "Loading.." // String
    
    let service: TimeService!
    
    private var bag = Set<AnyCancellable>()

    init() {
        self.service = TimeService.init(repository: UtcTimeRepository())
    }
    
    func reload() {
        // Model -> ViewModel
        dateTimeString = "Loading.."
        
        service.reloadNow()
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] model in
                let dateString = model.currentDate.dateToString()
                self?.dateTimeString = dateString
            })
            .store(in: &bag)
    }

    func moveDay(day: Int) {
        service.moveDay(day: day)
        dateTimeString = service.currentModel.currentDate.dateToString()
    }
}



//        service.fetchUserList()
//            .sink(receiveCompletion: { _ in
//            }, receiveValue: { list in
//                print("list: \(list)")
////                let dateString = model.currentDateTime.dateToString()
////                self?.dateTimeString = dateString
//            })
//            .store(in: &bag)
