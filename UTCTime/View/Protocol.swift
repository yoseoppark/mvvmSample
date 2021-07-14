//
//  Protocol.swift
//  UTCTime
//
//  Created by YoseopPark on 2021/07/12.
//

import Foundation
import Combine

protocol UtcTimeAPIProtocol {
    func currentUtcTime() -> AnyPublisher<UtcTimeModel, Error>
}

protocol UtcTimeServiceProtocol {
    var currentModel: TimeModel { get set }
    func reloadNow() -> AnyPublisher<TimeModel, Error>
    func moveDay(day: Int)
}
