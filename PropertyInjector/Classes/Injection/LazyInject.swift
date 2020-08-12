//
//  PropertyInjector
//  Created by Stan Feldman on 10/8/20.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

/**
Declare your dependency object as a property and add `@LazyInject` property wrapper.
The dependency will be automatically resolved when you try to use it for the first time.
```
class ViewController: UIViewController {
    @LazyInject private var dependency: MyDependency
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // dependency is resolved only at this stage
        dependency.doSomething()
    }
}
```
*/
@propertyWrapper
public struct LazyInject<T: Injectable> {
    
    private var valueHolder: T? = nil
    private let parameters: DependencyParameters

    public var wrappedValue: T {
        mutating get {
            if let value = valueHolder {
                return value
            } else {
                valueHolder = DependencyResolver.resolve(with: parameters)
                valueHolder?.initCompleted(with: parameters)
            }
            
            return self.wrappedValue
        }
    }
    
    public init(with parameters: DependencyParameters = defaultDependencyParameters) {
        self.parameters = parameters
    }
}
