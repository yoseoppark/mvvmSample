//
//  Repository.swift
//  UTCTime
//
//  Created by Chiwon Song on 2021/05/31.
//

import Foundation
import Combine

class UtcTimeRepository: UtcTimeRepositoryProtocol {
    var dataSource = RepositoryDataSource()
    
    func currentUtcTime() -> AnyPublisher<UtcTimeModel, Error> {
        return dataSource.reloadNow()
    }
}
