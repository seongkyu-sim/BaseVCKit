# BaseVCKit

[![CI Status](http://img.shields.io/travis/seongkyu-sim/BaseVCKit.svg?style=flat)](https://travis-ci.org/seongkyu-sim/BaseVCKit)
[![Version](https://img.shields.io/cocoapods/v/BaseVCKit.svg?style=flat)](http://cocoapods.org/pods/BaseVCKit)
[![License](https://img.shields.io/cocoapods/l/BaseVCKit.svg?style=flat)](http://cocoapods.org/pods/BaseVCKit)
[![Platform](https://img.shields.io/cocoapods/p/BaseVCKit.svg?style=flat)](http://cocoapods.org/pods/BaseVCKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 9.0+
- Xcode 8.0+
- Swift 4.0+

## Installation

### CocoaPods

BaseVCKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

pod "BaseVCKit"
```
### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate SnapKit into your project manually.


## Usage

### EasyNavigatable, NavButtonConfigurable

```swift
import BaseVCKit


public class ViewController: UIViewController, EasyNavigatable {

    private lazy var nextBtn: UIView = {
        let v = UIButton()
        v.setTitle("Next", for: .normal)
        v.addTarget(self, action: #selector(next), for: .touchUpInside)
        self.view.addSubview(v)
        return v
        }()

    public override func viewDidLoad() {
        super.viewDidLoad()

        nextBtn.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(60)
        }
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        startKeyboardAnimationObserve()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        stopKeyboardAnimationObserve()
    }


    // MARK: - Action

    func next(sender: UIButton!) {
        let nextVC = UIViewController()
        push(nextVC, isHideBottomBar: true)
    }
}


// NavButtonConfigurable
extension ViewController: NavButtonConfigurable {

    public var backButtonIcon: UIImage? {
        return UIImage(named: "back")
    }
    public var backButtonTitle: String? {
        return ""
    }
    public var closeButtonIcon: UIImage? {
        return UIImage(named: "close")
    }
}
```

### KeyboardSnapable
```swift
import UIKit
import BaseVCKit

class UseKeyboardViewController: BaseViewController {

    private lazy var txtField: UITextField = {
        let v = UITextField()
        v.backgroundColor = UIColor.lightGray
        self.view.addSubview(v)
        return v
    }()
    fileprivate lazy var doneBtn: UIButton = { [unowned self] in
        let v = UIButton()
        v.setTitle("Done", for: .normal)
        v.backgroundColor = .lightGray
        v.addTarget(self, action: #selector(self.done), for: .touchUpInside)
        self.view.addSubview(v)
        return v
        }()


    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Modal"
        layoutSubViews()
    }


    // MARK: - Layout

    private func layoutSubViews() {
        let marginH: CGFloat = 20

        txtField.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.equalTo(marginH)
            make.right.equalTo(-marginH)
            make.height.equalTo(40)
        }

        doneBtn.snp.makeConstraints { (make) in
            make.left.equalTo(marginH)
            make.right.equalTo(-marginH)
            make.bottom.equalToSuperview().offset(-keyboardFollowOffset)
        }
    }


    // MARK: - Actions

    @objc private func done(sender:UIButton!) {
        view.endEditing(true)
    }
}

// KeyboardObserable
extension ModalViewController: KeyboardSanpable {

    public var keyboardFollowView: UIView? {
        return doneBtn
    }
    public var keyboardFollowOffset: CGFloat {
        return 16
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        startKeyboardAnimationObserveWithViewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        stopKeyboardAnimationObserveWithViewWillDisAppear()
    }
}
```
### TabbarVCGenerator


```swift
import UIKit
import BaseVCKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let w = window {
            w.backgroundColor = UIColor.white
            w.rootViewController = CustomTabbar.tabVC
            w.makeKeyAndVisible()
        }
        return true
    }
}


// MARK: - Spec of TabbarItems

public enum CustomTabbar {
    case home, setting
    
    public static var tabVC: UITabBarController {
        return TabbarVCGenerator.tabVC(menuSpecs: self.allTabMenuSpec)
    }

    static var allTabMenuSpec: [TabbarVCGenerator.TabMenuSpec] {
        return [self.home, self.setting].map{ $0.toMenuSpec }
    }

    var toMenuSpec: TabbarVCGenerator.TabMenuSpec {

        var systemItem: UITabBarSystemItem!
        var vc: UIViewController!
        switch self {
        case .home:
            vc = ViewController()
            systemItem = .search
        case .setting:
            vc = ViewController2()
            systemItem = .history
        }
        return TabbarVCGenerator.TabMenuSpec(viewController: vc, systemItem: systemItem)
    }
}

```

## Dependencies
- [SnapKit](https://github.com/SnapKit/SnapKit) (3.2.0) - A Swift Autolayout DSL for iOS & OS X


## Author

seongkyu-sim, seongkyu.sim@gmail.com

## License

BaseVCKit is available under the MIT license. See the LICENSE file for more info.
