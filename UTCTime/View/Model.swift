//
//  Model.swift
//  UTCTime
//
//  Created by Chiwon Song on 2021/05/31.
//

import Foundation

struct MyDateModel {
    var currentDateTime: Date
}

struct MyUserModel: Codable {
    let email, name: String
    let avatarUrlString: String
}
