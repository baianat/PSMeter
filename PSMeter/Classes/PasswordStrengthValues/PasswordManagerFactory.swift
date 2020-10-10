//
//  BasePasswordStrengthValue.swift
//  PasswordStrengthMeter
//
//  Created by Omar on 9/7/20.
//  Copyright © 2020 Baianat. All rights reserved.
//

import UIKit

class PasswordManagerFactory {

    static func create(forPassword password: String, with decorator: PStrengthViewStatesDecorator, using estimator: PasswordEstimator) -> BasePasswordManager {
        switch estimator.estimatePassword(password) {
        case .empty:
            return EmptyPasswordManager(decorator: decorator.emptyPasswordDecorator)
        case .veryWeak:
            return VeryWeakStrengthPasswordManager(decorator: decorator.veryWeakPasswordDecorator)
        case .weak:
            return WeakPasswordManager(decorator: decorator.weakPasswordDecorator)
        case .fair:
            return FairPasswordManager(decorator: decorator.fairPasswordDecorator)
        case .strong:
            return StrongPasswordManager(decorator: decorator.strongPasswordDecorator)
        case .veryStrong:
            return VeryStrongStrengthPasswordManager(decorator: decorator.veryStrongPasswordDecorator)
        }

    }
}

public enum PasswordStrength {
    case empty
    case veryWeak
    case weak
    case fair
    case strong
    case veryStrong
}
