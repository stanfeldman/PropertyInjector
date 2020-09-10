# PropertyInjector

<a href="https://swift.org"><img src="https://img.shields.io/badge/language-Swift%205.1+-ee5137.svg" alt="Language" /></a>
<a href="https://developer.apple.com/ios"><img src="https://img.shields.io/badge/platform-iOS%2011+-000000.svg" alt="Platform" /></a>
[![Version](https://img.shields.io/cocoapods/v/PropertyInjector.svg?style=flat)](https://cocoapods.org/pods/PropertyInjector)

## Why should I use PropertyInjector?
Dependency injection, in general, is beneficial for your application because it promotes loosely coupled architecture and improves testability. There are several ways of implementing dependency injection, but I believe **property dependency injection is the most versatile and easy to use** one. This library is an implementation of property dependency injection where you just need to **declare your dependencies** and **use them as properties** in your classes. No constructor parameters, no extra code.

## Getting started

### Install the library

For Cocoapods, add the following line to your Podfile:

```ruby
pod 'PropertyInjector'
```

For Carthage, add the following line to your Cartfile:

```ruby
github "stanfeldman/PropertyInjector"
```

### Register your dependencies

You need to make sure that your dependencies get registered before they are injected. You can create a manager class and register the dependencies in its constructor.

```swift
class DependencyManager {
    init() {
        DependencyResolver.register {
            $0.singleton(MyDependency())
            // or
            $0.singleton(MyInterface.self, MyImplementation())
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

## Features

### Resolution strategies

There are 2 supported resolution strategies:

* `factory` creates your dependency every time it is resolved
* `singleton` creates your dependency only once and reuses the instance

```swift
DependencyResolver.register {
    $0.factory(MyDependency())
    $0.singleton(MyDependency())
}
```

### Dependency parameters

You can register a dependency with parameters.

```swift
DependencyResolver.register {
    $0.factory(MyDependency.self) { parameters in
        return MyDependency(name: parameters["name"] as! String)
    }
}
```

And then resolve it using some parameters:

```swift
@Inject(with: ["name": "Boris"]) private var dependency: MyDependency
```

or

```swift
let sub2: SubDependency2 = DependencyResolver.resolve(with: ["name": "Boris"])
```

### Manual dependency resolution

Automatic property injection using `@Inject` is preferable, but it is possible to manually resolve a dependency.

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

### Optionals resolution

PropertyInjector will try to resolve an unwrapped type for optionals.


```swift
class ViewController: UIViewController {
    @Inject private var dependency: MyDependency? // will try to resolve as MyDependency
    @Inject private var dependency: MyDependency! // the same
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## License

PropertyInjector is available under the MIT license. See the LICENSE file for more info.
