//
//  Protocol.swift
//  UTCTime
//
//  Created by YoseopPark on 2021/07/12.
//

import Foundation
import Combine

protocol UtcTimeRepositoryProtocol {
    func currentUtcTime() -> AnyPublisher<UtcTimeModel, Error>
}
