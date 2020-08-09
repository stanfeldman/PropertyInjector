//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

import PropertyInjector

class Dependency1: Injectable {
    
    /// Circular dependency, resolve manually
    private weak var content: Content?
    
    required init(from resolver: DependencyResolver, with parameters: DependencyParameters) {
        print("from Dependency1(\(UUID().uuidString)), parameters: \(parameters)")
    }
    
    func initCompleted(from resolver: DependencyResolver, with parameters: DependencyParameters) {
        // deferred resolution of a circular dependency
        content = resolver.resolve(with: parameters)
    }
}

class Dependency2: Injectable {
    required init(from resolver: DependencyResolver, with parameters: DependencyParameters) {
        print("from Dependency2(\(UUID().uuidString)), parameters: \(parameters)")
    }
}

class Content: Injectable {
    @Inject var dependency: Dependency1
    
    required init(from resolver: DependencyResolver, with parameters: DependencyParameters) {
        print("from Content(\(UUID().uuidString))")
    }
}
