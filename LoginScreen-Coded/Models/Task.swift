//
//  Tasks.swift
//  LoginScreen-Coded
//
//  Created by Leonel Ferraz Hernandez on 08/05/25.
//

import Foundation

struct Tasks: Codable {
    var id = UUID()
    let name: String
    let category: Category
    let description: String
    var isDone: Bool
}
