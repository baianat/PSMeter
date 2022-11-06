//
//  ValuesTextColors.swift
//  PasswordStrengthMeter
//
//  Created by Omar on 9/7/20.
//  Copyright © 2020 Baianat. All rights reserved.
//

import UIKit
public struct PStrengthViewStatesDecorator {

    var emptyPasswordDecorator: StateDecorator!
    var veryWeakPasswordDecorator: StateDecorator!
    var weakPasswordDecorator: StateDecorator!
    var fairPasswordDecorator: StateDecorator!
    var strongPasswordDecorator: StateDecorator!
    var veryStrongPasswordDecorator: StateDecorator!

    static let veryWeakColor = #colorLiteral(red: 0.8705882353, green: 0.02745098039, blue: 0, alpha: 1)
    static let weakColor = #colorLiteral(red: 0.8666666667, green: 0.2196078431, blue: 0.003921568627, alpha: 1)
    static let fairColor = #colorLiteral(red: 0.9960784314, green: 0.7960784314, blue: 0, alpha: 1)
    static let strongColor = #colorLiteral(red: 0.1843137255, green: 0.9019607843, blue: 0.0431372549, alpha: 1)
    static let veryStrongColor = #colorLiteral(red: 0.1058823529, green: 0.5882352941, blue: 0.02352941176, alpha: 1)

    public init(
        emptyPasswordDecorator: StateDecorator,
        veryWeakPasswordDecorator: StateDecorator,
        weakPasswordDecorator: StateDecorator,
        fairPasswordDecorator: StateDecorator,
        strongPasswordDecorator: StateDecorator,
        veryStrongPasswordDecorator: StateDecorator
    ) {
        self.emptyPasswordDecorator = emptyPasswordDecorator
        self.veryWeakPasswordDecorator = veryWeakPasswordDecorator
        self.weakPasswordDecorator = weakPasswordDecorator
        self.fairPasswordDecorator = fairPasswordDecorator
        self.strongPasswordDecorator = strongPasswordDecorator
        self.veryStrongPasswordDecorator = veryStrongPasswordDecorator
    }

    public static func defaultValues() -> PStrengthViewStatesDecorator {
        return PStrengthViewStatesDecorator(
            emptyPasswordDecorator: StateDecorator(text: "--", textColor: .gray, progressColor: .gray),
            veryWeakPasswordDecorator: StateDecorator(text: "veryWeak".localized, textColor: veryWeakColor, progressColor: veryWeakColor),
            weakPasswordDecorator: StateDecorator(text: "weak".localized, textColor: weakColor, progressColor: weakColor),
            fairPasswordDecorator: StateDecorator(text: "fair".localized, textColor: fairColor, progressColor: fairColor),
            strongPasswordDecorator: StateDecorator(text: "strong".localized, textColor: strongColor, progressColor: strongColor),
            veryStrongPasswordDecorator: StateDecorator(text: "veryStrong".localized, textColor: veryStrongColor, progressColor: veryStrongColor))
    }

}

public struct StateDecorator: ViewDecoratorProtocol {
    var title: String!
    var textColor: UIColor!
    var progressColor: UIColor!

    public init(
        text: String,
        textColor: UIColor,
        progressColor: UIColor) {
        self.title = text
        self.textColor = textColor
        self.progressColor = progressColor
    }
}

protocol ViewDecoratorProtocol {
    var title: String! {get set}
    var textColor: UIColor! {get set}
    var progressColor: UIColor! {get set}
}

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.init(for: PSMeter.self), value: "", comment: "")
    }
}
