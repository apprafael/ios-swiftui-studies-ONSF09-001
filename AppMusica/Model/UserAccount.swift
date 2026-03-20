//
//  UserAccount.swift
//  AppMusica
//
//  Created by Jessica Costa on 21/02/26.
//

import Foundation
import SwiftData

@Model
final class UserAccount {
    var name: String
    var username: String
    var password: String
    var createdAt: Date

    init(name: String, username: String, password: String, createdAt: Date = .now) {
        self.name = name
        self.username = username
        self.password = password
        self.createdAt = createdAt
    }
}
