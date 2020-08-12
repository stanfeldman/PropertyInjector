# PropertyInjector

<a href="https://swift.org"><img src="https://img.shields.io/badge/language-Swift%205.2-ee5137.svg" alt="Language" /></a>
<a href="https://developer.apple.com/ios"><img src="https://img.shields.io/badge/platform-iOS%2011+-000000.svg" alt="Platform" /></a>
[![Version](https://img.shields.io/cocoapods/v/PropertyInjector.svg?style=flat)](https://cocoapods.org/pods/PropertyInjector)

## Requirements

PropertyInjector supports Swift 5.1+ and iOS 11+.

## Getting started

### Install the pod

PropertyInjector is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PropertyInjector'
```

### Register your dependencies

You need to make sure that your dependencies get registered before they are injected. You can create a manager class and register the dependencies in its constructor.

```swift
class DependencyManager {
    init() {
        DependencyResolver.register {
            $0.singleton(MyDependency.self, MyDependency())
        }
    }
}
```

And add this manager to your `AppDelegate` for UIKit projects and `App` object for SwiftUI projects.

```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let dependencyManager = DependencyManager()
}
```

### Inject your dependencies

Just declare your dependency object as a property and add `@Inject` property wrapper. The dependency will be lazily resolved when the object is used.

```swift
class ViewController: UIViewController {
    @Inject private var dependency: MyDependency
}
```

## Advanced features

### Dependency parameters

You can register a dependency with parameters.

```swift
DependencyResolver.register {
	$0.factory(MyDependency.self) { parameters in
		return MyDependency(name: parameters["name"] as! String)
	}
}
```

### Manual dependency resolution

Automatic property injection using `@Inject` is prefferable, but it is possible to manually resolve a dependency.

```swift
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let dependency1: MyDependency1 = DependencyResolver.resolve()
        let dependency2: MyDependency2 = DependencyResolver.resolve(with: ["uuid": UUID().uuidString])
    }
}
```

### Circular dependencies

Dependencies are resolved on demand so there is no problem injecting class B into class A and class A into class B as long as both dependencies are not used in their constructors.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## License

PropertyInjector is available under the MIT license. See the LICENSE file for more info.
