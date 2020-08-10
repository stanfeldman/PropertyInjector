//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

/**
 A protocol with a single `apply(_:)` method used to create nice syntax like this:
 ```
 DependencyResolver.shared.register {
     $0.factory(type: MyDependency.self)
     $0.single(type: AnotherDependency.self)
 }
 ```
 */
protocol Applicable {}

extension Applicable {
    
    /// Call methods of a closure from inside an object.
    func apply(_ closure: (Self) -> Void) {
        closure(self)
    }
}
