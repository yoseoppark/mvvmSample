//
//  Logic.swift
//  UTCTime
//
//  Created by Chiwon Song on 2021/05/31.
//

import Foundation
import Combine

class UtcTimeService: UtcTimeServiceProtocol {
    
    var currentModel = TimeModel(currentDateTime: Date())
    
    let api: UtcTimeAPIProtocol
    
    init(api: UtcTimeAPIProtocol) {
        self.api = api
    }
    
    func reloadNow() -> AnyPublisher<TimeModel, Error> {
        // Entity -> TimeModel
        return api.currentUtcTime()
            .map({ entity -> TimeModel? in
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
                guard let now = formatter.date(from: entity.currentDateTime) else { return nil }
                let model = TimeModel(currentDateTime: now)
                self.currentModel = model
                return model
            })
            .compactMap{$0}
            .eraseToAnyPublisher()
    }
    
    func moveDay(day: Int) {
        guard let movedDay = Calendar.current.date(byAdding: .day,
                                                   value: day,
                                                   to: currentModel.currentDateTime) else {
            return
        }
        currentModel.currentDateTime = movedDay
    }
}


//    func fetchUserList() -> AnyPublisher<[MyUserModel], Error> {
//        return api.fetchUserList()
//            .map({ entity -> [MyUserModel] in
//                let list = entity.data.map{
//                    MyUserModel.init(email: $0.email, name: $0.firstName + $0.lastName, avatarUrlString: $0.avatar)
//                }
//
//                self.currentUserList = list
//                return list
//            })
//            .compactMap{$0}
//            .eraseToAnyPublisher()
//    }
