//
//  PropertyInjector
//  Created by Stan Feldman on 10/8/20.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

/**
 Conform to `Injectable` protocol to make your dependency injectable via property injection.
 ```
 class MyDependency: Injectable {
     required init(from resolver: DependencyResolver, with parameters: DependencyParameters) {
         // your custom initialization logic
         // parametersProvider is a closure returning [String: Any?]
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
