//
//  Category.swift
//  LoginScreen-Coded
//
//  Created by Leonel Ferraz Hernandez on 07/05/25.
//

enum Category: String, CaseIterable, Codable {
    case education
    case fitness
    case groceries
    case health
    case home
    case personal
    case reading
    case shopping
    case travel
    case other

    var imageName:  String  {
        switch self {
        case .education:
            return "graduationcap.fill"
        case .fitness:
            return "dumbbell.fill"
        case .groceries:
            return "fork.knife"
        case .health:
            return "pills.fill"
        case .home:
            return "house.fill"
        case .personal:
            return "person.fill"
        case .reading:
            return "book.fill"
        case .shopping:
            return "cart.fill"
        case .travel:
            return "airplane"
        case .other:
            return "ellipsis"
        }
    }
}
