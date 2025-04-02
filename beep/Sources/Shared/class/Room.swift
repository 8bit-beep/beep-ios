//
//  Room.swift
//  beep
//
//  Created by cher1shRXD on 4/2/25.
//

import Foundation

class Room {
    let roomList = [
        RoomModel(id: 1, name: "PROJECT3", club: "CHATTY"),
        RoomModel(id: 2, name: "PROJECT4", club: "DUCAMI"),
        RoomModel(id: 3, name: "PROJECT5", club: "BIND"),
        RoomModel(id: 4, name: "PROJECT6", club: "SAMDI"),
        RoomModel(id: 5, name: "LAB15_16", club: "MODI"),
        RoomModel(id: 6, name: "LAB17_18", club: "CNS"),
        RoomModel(id: 7, name: "LAB19_20", club: "ROUTER"),
        RoomModel(id: 8, name: "LAB21_22", club: "ALT"),
    ]
    
    let parseRoomName: (String) -> String = { name in
        if name.starts(with: "PROJECT") {
            let number = name.dropFirst(7)
            return "프로젝트 \(number)"
        } else if name.starts(with: "LAB") {
            let numbers = name.dropFirst(3).split(separator: "_").map { String($0) }
            if numbers.count == 2 {
                return "랩 \(numbers[0]), \(numbers[1])"
            }
        }
        return name
    }
}
