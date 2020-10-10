//
//  PStrengthView.swift
//  PasswordStrengthMeter
//
//  Created by Omar on 9/7/20.
//  Copyright © 2020 Baianat. All rights reserved.
//

import UIKit
import GTProgressBar
public protocol PSMeterDelegate {

    func psMeter(_ psMeter: PSMeter, didChangeStrength passwordStrength: PasswordStrength)

}

@IBDesignable public class PSMeter: UIView {

    // MARK: Public Attributes

    @IBInspectable public var titleText: String = "passwordStrength".localized {
        didSet {
            self.strengthTitleLabel.text = titleText
        }
    }

    @IBInspectable public var titleTextColor: UIColor = .black {
        didSet {
            self.strengthTitleLabel.textColor = titleTextColor
        }
    }

    public var statesDecorator: PStrengthViewStatesDecorator! {
        didSet {
            if passwordManager == nil {
                passwordManager = EmptyPasswordManager(decorator: statesDecorator.emptyPasswordDecorator)
            } else {
                passwordManager.updateDecorator(statesDecorator: statesDecorator)
            }
            delegate?.psMeter(self, didChangeStrength: passwordManager.passwordStrength())
            updateView(passwordStrengthManager: passwordManager)
        }
    }

    @IBInspectable public var barBackgroundColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) {
        didSet {
            strengthProgressBar.barBackgroundColor = barBackgroundColor
        }
    }

    public var font: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            strengthTitleLabel.font = font
            strengthValueLabel.font = font
        }
    }

    public var passwordEstimator: PasswordEstimator!

    // MARK: Views
    lazy var parentStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = Measurements.VERTICAL_ITEMS_SPACING
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var strengthProgressBar: GTProgressBar = {
        var progressBar = GTProgressBar()
        progressBar.barFillColor = .red
        progressBar.progress = 0.0
        progressBar.displayLabel = false
        progressBar.barBorderColor = .clear
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.heightAnchor.constraint(equalToConstant: Measurements.PROGRESS_BAR_HEIGHT).isActive = true
        return progressBar
    }()

    lazy var labelsStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = Measurements.HORIZONTAL_ITEMS_SPACING
        return stackView
    }()

    lazy var strengthTitleLabel: UILabel = {
        var label = UILabel()
        label.font = font
        label.textColor = titleTextColor
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()

    lazy var strengthValueLabel: UILabel = {
        var label = UILabel()
        label.font = font
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()

    // MARK: Variables
    private var passwordManager: BasePasswordManager!

    public var delegate: PSMeterDelegate? {
        didSet {
            delegate?.psMeter(self, didChangeStrength: passwordManager?.passwordStrength() ?? .empty)
        }
    }
    public var passwordStrength: PasswordStrength? {
        return passwordManager?.passwordStrength()
    }

    // MARK: Inits

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        setupConstraint()
        setInitialDecoratorAndPasswordEstimator()
    }

    private func setupConstraint() {
        labelsStackView.addArrangedSubview(strengthTitleLabel)
        labelsStackView.addArrangedSubview(strengthValueLabel)

        parentStackView.addArrangedSubview(strengthProgressBar)
        parentStackView.addArrangedSubview(labelsStackView)

        addSubview(parentStackView)
        parentStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        parentStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        parentStackView.topAnchor.constraint(equalTo: topAnchor, constant: Measurements.VERTICAL_SPACING).isActive = true
        parentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Measurements.VERTICAL_SPACING).isActive = true
    }

    private func setInitialDecoratorAndPasswordEstimator() {
        statesDecorator = PStrengthViewStatesDecorator.defaultValues()
        passwordEstimator = DefaultPasswordEstimator()
    }

    public func updateStrengthIndication(password: String) {
        if let previousPasswordManager = passwordManager {
            let currentPasswordManager = PasswordManagerFactory.create(forPassword: password, with: statesDecorator, using: passwordEstimator)
            self.passwordManager = currentPasswordManager
            if currentPasswordManager != previousPasswordManager {
                delegate?.psMeter(self, didChangeStrength: currentPasswordManager.passwordStrength())
            }
            updateView(passwordStrengthManager: currentPasswordManager)
        } else {
            passwordManager = PasswordManagerFactory.create(forPassword: password, with: statesDecorator, using: passwordEstimator)
            delegate?.psMeter(self, didChangeStrength: passwordManager.passwordStrength())
            updateView(passwordStrengthManager: self.passwordManager)
        }
    }

    private func updateView(passwordStrengthManager: BasePasswordManager) {
        strengthProgressBar.animateTo(progress: CGFloat(passwordStrengthManager.strengthValue()))

        strengthValueLabel.text = passwordStrengthManager.strengthTitle()

        UIView.animate(withDuration: 0.2) {
            self.strengthProgressBar.barFillColor = passwordStrengthManager.progressTextColor()
        }
        strengthValueLabel.textColor = passwordStrengthManager.valueTextColor()
    }

}
