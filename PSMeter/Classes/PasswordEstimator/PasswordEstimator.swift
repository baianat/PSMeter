//
//  PasswordEstimator.swift
//  PasswordStrengthMeter
//
//  Created by Omar on 9/15/20.
//  Copyright © 2020 Baianat. All rights reserved.
//

import Foundation
import Navajo_Swift

public protocol PasswordEstimator {
    func estimatePassword(_ password: String) -> PasswordStrength
}

struct DefaultPasswordEstimator: PasswordEstimator {
    func estimatePassword(_ password: String) -> PasswordStrength {

        if password.isEmpty {
            return .empty
        } else {
            let strength = Navajo.strength(ofPassword: password)
            switch strength {
            case .veryWeak:
                return .veryWeak
            case .weak:
                return .weak
            case .reasonable:
                return .fair
            case .strong:
                return .strong
            case .veryStrong:
                return .veryStrong
            }
        }
    }

}
