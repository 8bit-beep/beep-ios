//
//  DauthModel.swift
//  beep
//
//  Created by cher1shRXD on 4/2/25.
//

struct DauthModel: Codable {
    let data: DauthData
    let status: Int
    let message: String
}

struct DauthData: Codable {
    let location: String
    let name: String
    let profileImage: String?
}
