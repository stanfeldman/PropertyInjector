# PropertyInjector

[![CI Status](https://img.shields.io/travis/stanfeldman/PropertyInjector.svg?style=flat)](https://travis-ci.org/stanfeldman/PropertyInjector)
[![Version](https://img.shields.io/cocoapods/v/PropertyInjector.svg?style=flat)](https://cocoapods.org/pods/PropertyInjector)
[![Platform](https://img.shields.io/cocoapods/p/PropertyInjector.svg?style=flat)](https://cocoapods.org/pods/PropertyInjector)

## Requirements

PropertyInjector supports Swift 5.1+ and iOS 11+.

## Getting started

### Install the pod

PropertyInjector is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PropertyInjector'
```

### Make your dependency classes injectable

Inherit from `Injectable` and implement an initalizer which will be called when your dependency is created.

```swift
class MyDependency: Injectable {
    required init(parameters: DependencyParameters) {
        // your custom initialization logic
        // DependencyParameters is just [String: Any?]
    }
}
```

### Register your dependencies

You need to make sure that your dependencies get registered before they are injected. You can create a manager class and register the dependencies in its constructor.

```swift
import PropertyInjector

class DependencyManager {
    init() {
        DependencyResolver.shared.register {
            $0.factory(type: MyDependency.self)
        }
    }
}
```

And add this manager to your AppDelegate.

```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let dependencyManager = DependencyManager()
}
```

### Inject your dependencies

Just declare your dependency object as a property and add `@Inject` property wrapper. The dependency will be automatically resolved and ready to use.

```swift
import PropertyInjector
import UIKit

class ViewController: UIViewController {
    @Inject private var dependency: MyDependency
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## License

PropertyInjector is available under the MIT license. See the LICENSE file for more info.
