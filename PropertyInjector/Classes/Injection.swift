//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

/**
 Conform to `Injectable` protocol to make your dependency injectable via property injection.
 ```
 class MyDependency: Injectable {
     required init(from resolver: DependencyResolver, with parameters: DependencyParameters) {
         // your custom initialization logic
         // DependencyParameters is just [String: Any?]
     }
 }
 ```
 */
public protocol Injectable {
    init(from resolver: DependencyResolver, with parameters: DependencyParameters)
}

extension Injectable {
    
    /// Initialization completed callback which is called when the object has been created.
    public func initCompleted(from resolver: DependencyResolver, with parameters: DependencyParameters) {}
}

/**
 A generic parameters bundle which can be passed to a dependency as input.
 */
public typealias DependencyParameters = [String: Any?]

/**
 Declare your dependency object as a property and add `@Inject` property wrapper.
 The dependency will be automatically resolved and ready to use.
 ```
 class ViewController: UIViewController {
     @Inject private var dependency: MyDependency
 }
 ```
 */
@propertyWrapper
public struct Inject<T: Injectable> {
    public let wrappedValue: T
    
    public init(parameters: DependencyParameters = [:]) {
        let resolver = DependencyResolver.shared
        wrappedValue = resolver.resolve(with: parameters)
        wrappedValue.initCompleted(from: resolver, with: parameters)
    }
}
