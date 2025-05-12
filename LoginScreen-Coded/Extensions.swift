//
//  Extensions.swift
//  LoginScreen-Coded
//
//  Created by Leonel Ferraz Hernandez on 08/05/25.
//

import Foundation
import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
