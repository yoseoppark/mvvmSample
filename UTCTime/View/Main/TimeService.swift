//
//  Logic.swift
//  UTCTime
//
//  Created by Chiwon Song on 2021/05/31.
//

import Foundation
import Combine

class TimeService {
    
    var currentModel: UtcTimeModel!
    
    let repository: UtcTimeRepositoryProtocol
    
    init(repository: UtcTimeRepositoryProtocol) {
        self.repository = repository
    }

    func reloadNow() -> AnyPublisher<UtcTimeModel, Error> {
        // Entity -> TimeModel
        return repository.currentUtcTime()
            .map({ entity in
                var new = entity
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
                guard let now = formatter.date(from: entity.currentDateTime) else { return nil }
                new.currentDate = now
                self.currentModel = new
                return new
            })
            .compactMap{$0}
            .eraseToAnyPublisher()
    }
    
    func moveDay(day: Int) {
        guard let movedDay = Calendar.current.date(byAdding: .day, value: day, to: currentModel.currentDate) else {
            return
        }
        currentModel.currentDate = movedDay
    }
}

//    func fetchUserList() -> AnyPublisher<[MyUserModel], Error> {
//        return repository.fetchUserList()
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
