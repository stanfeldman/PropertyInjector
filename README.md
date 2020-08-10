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

### Make your dependency classes injectable

Inherit from `Injectable` and implement an initalizer which will be called when your dependency is created.

```swift
class MyDependency: Injectable {
    required init(from resolver: DependencyResolver, with parameters: DependencyParameters) {
        // your custom initialization logic
        // DependencyParameters is just [String: Any?]
    }
}
```

### Register your dependencies

You need to make sure that your dependencies get registered before they are injected. You can create a manager class and register the dependencies in its constructor.

```swift
class DependencyManager {
    init() {
        DependencyResolver.shared.register {
            $0.factory(type: MyDependency.self)
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

Just declare your dependency object as a property and add `@Inject` property wrapper. The dependency will be automatically resolved and ready to use.

```swift
class ViewController: UIViewController {
    @Inject private var dependency: MyDependency
}
```

## Advanced features

### Lazy injection

Use `@LazyInject` property wrapper to have a dependency created only when it is used.

```swift
class ViewController: UIViewController {
    @LazyInject private var dependency: MyDependency
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // dependency is resolved only at this stage
        dependency.doSomething()
    }
}
```

### Manual dependency resolution

Automatic property injection using `@Inject` is prefferable, but it is possible to manually resolve a dependency.

```swift
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let dependency: Dependency2 = DependencyResolver.shared.resolve(with: ["uuid": UUID().uuidString])
    }
}
```

### Circular dependencies

Do not simply try to inject class B into class A and class A into class B. This type of dependency causes infinite recursion.
Use `initCompleted` callback to manually resolve a parent dependency.

```swift
class Dependency1: Injectable {
    
    /// Circular dependency, resolve manually
    private weak var content: Content?
    
    required init(from resolver: DependencyResolver, with parameters: DependencyParameters) {}
    
    func initCompleted(from resolver: DependencyResolver, with parameters: DependencyParameters) {
        // deferred resolution of a circular dependency
        content = resolver.resolve(with: parameters)
    }
}

class Content: Injectable {
    @Inject var dependency: Dependency1
    
    required init(from resolver: DependencyResolver, with parameters: DependencyParameters) {}
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## License

PropertyInjector is available under the MIT license. See the LICENSE file for more info.
