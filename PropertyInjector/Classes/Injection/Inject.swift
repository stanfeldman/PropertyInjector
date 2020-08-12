//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

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
    
    public init(with parameters: DependencyParameters = defaultDependencyParameters) {
        wrappedValue = DependencyResolver.resolve(with: parameters)
        wrappedValue.initCompleted(with: parameters)
    }
}
