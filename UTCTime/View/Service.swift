//
//  Logic.swift
//  UTCTime
//
//  Created by Chiwon Song on 2021/05/31.
//

import Foundation
import Combine

class Service: UTCTimeService {
    
    var currentModel = MyDateModel(currentDateTime: Date())
    
    let api: UTCTimeAPI
    
    init(api: UTCTimeAPI) {
        self.api = api
    }
    
    func fetchNow() -> AnyPublisher<MyDateModel, Error> {
        // Entity -> MyDateModel
        return api.currentUTCTime()
            .map({ entity -> MyDateModel? in
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
                guard let now = formatter.date(from: entity.currentDateTime) else { return nil }
                let model = MyDateModel(currentDateTime: now)
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
    
//    func fetchUserList() -> AnyPublisher<[MyUserModel], Error> {
//        // Entity -> MyDateModel
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
}
