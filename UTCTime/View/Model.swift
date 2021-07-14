//
//  Model.swift
//  UTCTime
//
//  Created by Chiwon Song on 2021/05/31.
//

import Foundation

struct TimeModel {
    var currentDateTime: Date
}

struct MyUserModel: Codable {
    let email, name: String
    let avatarUrlString: String
}
