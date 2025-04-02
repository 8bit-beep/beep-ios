//
//  UserModel.swift
//  beep
//
//  Created by cher1shRXD on 4/2/25.
//

struct UserModel: Codable {
    var data: UserData
    var status: Int
}

struct UserData: Codable {
    var username: String?
    var email: String?
    var grade: Int?
    var cls: Int?
    var num: Int?
    var fixedRoom: RoomModel?
    var status: String?
    var role: String?
}

