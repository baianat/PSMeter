# PSMeter
A password strength meter for iOS.

[![Version](https://img.shields.io/cocoapods/v/PSMeter.svg?style=flat)](https://cocoapods.org/pods/PSMeter)
[![License](https://img.shields.io/cocoapods/l/PSMeter.svg?style=flat)](https://cocoapods.org/pods/PSMeter)
[![Platform](https://img.shields.io/cocoapods/p/PSMeter.svg?style=flat)](https://cocoapods.org/pods/PSMeter)

<p align="center">
<img src="https://github.com/baianat/PSMeter/blob/main/InstructionAssets/preview.gif">
</p>

[Quick Start](#quick-start)

[Customization](#customization)
* [View Customization](#view-customization)
* [States Customization](#states-customization)

[Delegate (Callback)](#delegate-(callback))

[Password Strength Algorithm](#password-strength-algorithm)
* [Default Algorithm](#default-algorithm)
* [Custom Algorithm](#custom-algorithm)

[Installation](#installation)

### Quick Start:

1- Drag View object from the Object Library into your storyboard.
<p align="center">
<img src="https://github.com/baianat/PSMeter/blob/main/InstructionAssets/instruction1.png">
</p>

2- Set the view's class to `PSMeter` in the Identity Inspector. Set its module property to `PSMeter`.

<p align="center">
<img src="https://github.com/baianat/PSMeter/blob/main/InstructionAssets/instruction2.png">
</p>


3- Add `import PSMeter` to the header of your view controller.

4- Create an outlet in the corresponding view controller.
``` swift
@IBOutlet weak var psMeter: PSMeter!
```
5- Invoke `updateStrengthIndication(password:String)` on PSMeter instance to update the password strength indicator.

**Note**

`updateStrengthIndication(password:String)` should be called whenever the password text is changed to update the indicator appopriately.

This can easily be achieved in a couple of ways..

* **Using RxSwift** ...

``` swift
passwordTextField.rx.text.changed.subscribe(onNext: { (password) in
    self.psMeter.updateStrengthIndication(password: password ?? "")
}).disposed(by: bag)
```

* Using **IBActions** ...

1- create an `@IBAction` in your view controller for `Editing Changed`.

<p align="center">
<img src="https://github.com/baianat/PSMeter/blob/main/InstructionAssets/instruction3.png">
</p>
<p align="center">
<img src="https://github.com/baianat/PSMeter/blob/main/InstructionAssets/instruction4.png">
</p>

2- Invoke `updateStrengthIndication` in that action.
``` swift
@IBAction func passwordDidChange(_ sender: Any) {
    let password = passwordTextField.text ?? ""
    psMeter.updateStrengthIndication(password: password)
}
```

### Customization:

#### View Customization:

You can customize `PSMeter` for these attributes:
| Attribute  | Definition | Default value |
| ------------- | ------------- |------------- |
|titleText| the title across the strength value | `"Password Strength"` |
|titleTextColor  | the text color for the title | `.black` |
|font  | the font for both the title and the strength labels | `.systemFont(ofSize: 14)` |
| barBackgroundColor | the background color of the strength bar | `.clear` |

**Example:**
``` swift
override func viewDidLoad() {
    ...
    psMeter.titleText = "Password Robustness"
    psMeter.tintColor = .red
    psMeter.font = UIFont.boldSystemFont(ofSize: 14)
}
```

#### States Customization:
You can also customize **text, text color, progress color** for each of the 6 strength states.

These attributes are defined using `StateDecorator` object as follows...

``` swift
let weakPasswordDecorator = StateDecorator(text: "Weak", textColor: .red, progressColor: .red)
```
To customize all the stated you only have to set the six decorators for the six different states (empty, very weak, weak, fair, strong, very strong).

This can easily be achieved using `PStrengthViewStatesDecorator` object, the object combining all the decorators.

**Example:**
The default `PStrengthViewStatesDecorator` is implemented as follows...

``` swift
let defaultStatesDecorator =  PStrengthViewStatesDecorator(
    emptyPasswordDecorator:StateDecorator(text: "--", textColor: .gray, progressColor: .gray),
    veryWeakPasswordDecorator: StateDecorator(text: "Very Weak", textColor: .red, progressColor: .red),
    weakPasswordDecorator: StateDecorator(text: "Weak", textColor: .orange, progressColor: .orange),
    fairPasswordDecorator: StateDecorator(text: "Fair", textColor: .yellow, progressColor: .yellow),
    strongPasswordDecorator: StateDecorator(text: "Strong", textColor: .green, progressColor: .green),
    veryStrongPasswordDecorator: StateDecorator(text: "Very Strong", textColor: .blue, progressColor: .blue)
)
psMeter.statesDecorator = defaultStatesDecorator
```

### Delegate (Callback):
You can observe for whenever the password strength changes, just set the the delegate on `PSMeter` and implement `PsMeterDelegate` as follows...

``` swift
...
override func viewDidLoad() {
    super.viewDidLoad()
        ...
        psMeter.delegate = self
    }
}

extension ViewController : PSMeterDelegate {
    func psMeter(_ psMeter: PSMeter, didChangeStrength passwordStrength: PasswordStrength) {

    }
}
```
Alternatively, you can get the current password strength using `passwordStrength` on `PSMeter` as follows...

``` swift
let currentStrength = psMeter.passwordStrength
```

Either way passwordStrength is of type `PasswordStrength` enum that can have on of the following values...

``` swift
let currentStrength = psMeter.passwordStrength
switch currentStrength {
    case .empty:
        print("empty")
    case .veryWeak:
        print("veryWeak")
    case .weak:
        print("weak")
    case .fair:
        print("fair")
    case .strong:
        print("strong")
    case .veryStrong:
        print("veryStrong")
    default:
        break
}
```

### Password Strength Algorithm:

#### Default Algorithm:
The default algorithm for determining password strength is based on [Navajo-Swift](https://github.com/jasonnam/Navajo-Swift) by @jasonnam.

#### Custom Algorithm:
You can easily altar the algorithm defining how password strength is estimated, just set `passwordEstimator` on `PSMeter` and implement `PasswordEstimator` as follows...

**Example:** A custom algorithm that judges a password as weak only if its length is less than 8 character othewise fair can be defined as follows...

``` swift
...
override func viewDidLoad() {
        ...
        psMeter.passwordEstimator = self
    }
}

extension ViewController : PasswordEstimator {
    func estimatePassword(_ password: String) -> PasswordStrength {
        if password.count = 8 {
            return .weak
        }else {
            return .fair
        }
    }
}
```

### Installation:
To install PSMeter , simply add the following line to your Podfile:

```ruby
pod 'PSMeter'
```


### Dependency:
PSMeter uses [Navajo-Swift](https://github.com/jasonnam/Navajo-Swift) and [GTProgressBar](https://github.com/gregttn/GTProgressBar) under its hood, they gets automatically installed with your pods.

### License:
PSMeter is available under the MIT license. See the LICENSE file for more info.
