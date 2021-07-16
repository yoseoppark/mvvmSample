//
//  RepositoryDataSource.swift
//  UTCTime
//
//  Created by YoseopPark on 2021/07/16.
//

import Foundation
import Combine

class RepositoryDataSource {
    
    func reloadNow() -> AnyPublisher<UtcTimeModel, Error> {
        let urlStr = "http://worldclockapi.com/api/json/utc/now"
        let url = URL.init(string: urlStr)!
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                print("----------element: \(element)")
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: UtcTimeModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    // block
    func fetchNowWithBlock(onCompleted: @escaping (UtcTimeModel) -> Void) {
        let urlStr = "http://worldclockapi.com/api/json/utc/now"
        URLSession.shared.dataTask(with: URL(string: urlStr)!) { data, _, _ in
            guard let data = data else { return }
            guard let model = try? JSONDecoder().decode(UtcTimeModel.self, from: data) else { return }
            onCompleted(model)
        }.resume()
    }
    
//    // combine
//    func fetchUserList() -> AnyPublisher<UserDataAPIInfo, Error> {
//        let urlStr = "https://reqres.in/api/users?page=1"
//        let url = URL.init(string: urlStr)!
//        return URLSession.shared
//            .dataTaskPublisher(for: url)
//            .tryMap() { element -> Data in
//                guard let httpResponse = element.response as? HTTPURLResponse,
//                      httpResponse.statusCode == 200 else {
//                    throw URLError(.badServerResponse)
//                }
//                return element.data
//            }
//            .decode(type: UserDataAPIInfo.self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
//    }
}
