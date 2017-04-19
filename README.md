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
- Swift 3.0+

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

### Quick Start

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


// KeyboardObserable
extension ViewController: KeyboardSanpable {

    public var keyboardFollowView: UIView? {
        return nextBtn
    }

    fileprivate func startKeyboardAnimationObserve() {
        guard let _ = keyboardFollowView else { return }
        addKeyboardAnimationObserver()
    }

    fileprivate func stopKeyboardAnimationObserve() {
        removeKeyboardAnimationObserver()
    }
}
```


## Dependencies
- [SnapKit](https://github.com/SnapKit/SnapKit) (3.2.0) - A Swift Autolayout DSL for iOS & OS X


## Author

seongkyu-sim, seongkyu.sim@gmail.com

## License

BaseVCKit is available under the MIT license. See the LICENSE file for more info.
