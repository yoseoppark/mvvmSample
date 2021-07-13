//
//  ViewModel.swift
//  UTCTime
//
//  Created by Chiwon Song on 2021/05/31.
//

import Combine

class ViewModel {
    
    @Published var dateTimeString = "Loading.." // String
    
    let service: UTCTimeService
    
    private var bag = Set<AnyCancellable>()

    init(service: UTCTimeService) {
        self.service = service
    }
    
    func reload() {
        // Model -> ViewModel
        dateTimeString = "Loading.."
        
        service.fetchNow()
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] model in
                let dateString = model.currentDateTime.dateToString()
                self?.dateTimeString = dateString
            })
            .store(in: &bag)
        
//        service.fetchUserList()
//            .sink(receiveCompletion: { _ in
//            }, receiveValue: { list in
//                print("list: \(list)")
////                let dateString = model.currentDateTime.dateToString()
////                self?.dateTimeString = dateString
//            })
//            .store(in: &bag)
    }

    func moveDay(day: Int) {
        service.moveDay(day: day)
        dateTimeString = service.currentModel.currentDateTime.dateToString()
    }
}
