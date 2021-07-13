//
//  Repository.swift
//  UTCTime
//
//  Created by Chiwon Song on 2021/05/31.
//

import Foundation
import Combine

class UTCTimeImplimentAPI: UTCTimeAPI {
    var repository = Repository()
    func currentUTCTime() -> AnyPublisher<UtcTimeModel, Error> {
        return repository.fetchNow()
    }
}

class Repository {
    // block
    func fetchNow(onCompleted: @escaping (UtcTimeModel) -> Void) {
        let urlStr = "http://worldclockapi.com/api/json/utc/now"
        URLSession.shared.dataTask(with: URL(string: urlStr)!) { data, _, _ in
            guard let data = data else { return }
            guard let model = try? JSONDecoder().decode(UtcTimeModel.self, from: data) else { return }
            onCompleted(model)
        }.resume()
    }
    
    // combine
    func fetchNow() -> AnyPublisher<UtcTimeModel, Error> {
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
    
    // combine
    func fetchUserList() -> AnyPublisher<UserDataAPIInfo, Error> {
        let urlStr = "https://reqres.in/api/users?page=1"
        let url = URL.init(string: urlStr)!
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: UserDataAPIInfo.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}
