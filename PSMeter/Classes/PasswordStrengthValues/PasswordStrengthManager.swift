//
//  VeryWeakStrengthValue.swift
//  PasswordStrengthMeter
//
//  Created by Omar on 9/7/20.
//  Copyright © 2020 Baianat. All rights reserved.
//

import UIKit

class BasePasswordManager: Equatable {

    static func == (lhs: BasePasswordManager, rhs: BasePasswordManager) -> Bool {
        return lhs.passwordStrength() == rhs.passwordStrength()
    }

    var decorator: ViewDecoratorProtocol

    init(decorator: ViewDecoratorProtocol) {
        self.decorator = decorator
    }

    func valueTextColor() -> UIColor {
        return decorator.textColor
    }
    func progressTextColor() -> UIColor {
        return decorator.progressColor
    }
    func strengthTitle() -> String {
        return decorator.title
    }
    func strengthValue() -> Float {
        fatalError("Not Implemented")
    }
    func passwordStrength() -> PasswordStrength {
        fatalError("Not Implemented")
    }

    func updateDecorator(statesDecorator: PStrengthViewStatesDecorator) {

    }
}

class EmptyPasswordManager: BasePasswordManager {

    override func strengthValue() -> Float {
        return 0
    }

    override func passwordStrength() -> PasswordStrength {
        return .empty
    }
    override func updateDecorator(statesDecorator: PStrengthViewStatesDecorator) {
        decorator = statesDecorator.emptyPasswordDecorator
    }
}

class VeryWeakStrengthPasswordManager: BasePasswordManager {

    override func strengthValue() -> Float {
        return 0.2
    }

    override func passwordStrength() -> PasswordStrength {
        return .veryWeak
    }
    override func updateDecorator(statesDecorator: PStrengthViewStatesDecorator) {
        decorator = statesDecorator.veryWeakPasswordDecorator
    }
}

class WeakPasswordManager: BasePasswordManager {

    override func strengthValue() -> Float {
        return 0.4
    }

    override func passwordStrength() -> PasswordStrength {
        return .weak
    }
    override func updateDecorator(statesDecorator: PStrengthViewStatesDecorator) {
        decorator = statesDecorator.weakPasswordDecorator
    }
}

class FairPasswordManager: BasePasswordManager {

    override func strengthValue() -> Float {
        return 0.6
    }

    override func passwordStrength() -> PasswordStrength {
        return .fair
    }
    override func updateDecorator(statesDecorator: PStrengthViewStatesDecorator) {
        decorator = statesDecorator.fairPasswordDecorator
    }
}

class StrongPasswordManager: BasePasswordManager {

    override func strengthValue() -> Float {
        return 0.8
    }

    override func passwordStrength() -> PasswordStrength {
        return .strong
    }
    override func updateDecorator(statesDecorator: PStrengthViewStatesDecorator) {
        decorator = statesDecorator.strongPasswordDecorator
    }
}

class VeryStrongStrengthPasswordManager: BasePasswordManager {

    override func strengthValue() -> Float {
        return 1.0
    }

    override func passwordStrength() -> PasswordStrength {
        return .veryStrong
    }
    override func updateDecorator(statesDecorator: PStrengthViewStatesDecorator) {
        decorator = statesDecorator.veryStrongPasswordDecorator
    }
}
