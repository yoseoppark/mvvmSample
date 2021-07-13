//
//  Protocol.swift
//  UTCTime
//
//  Created by YoseopPark on 2021/07/12.
//

import Foundation
import Combine

protocol UTCTimeAPI {
    func currentUTCTime() -> AnyPublisher<UtcTimeModel, Error>
}

protocol UTCTimeService {
    var currentModel: MyDateModel { get set }
    func fetchNow() -> AnyPublisher<MyDateModel, Error>
    func moveDay(day: Int)
}
