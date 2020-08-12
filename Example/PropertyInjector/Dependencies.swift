//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

import PropertyInjector

class Dependency1: Injectable {
    
    /// Circular dependency, resolve manually
    private weak var content: Content?
    
    required init(with parameters: DependencyParameters) {
        print("from Dependency1(\(UUID().uuidString)), parameters: \(parameters)")
    }
    
    func initCompleted(with parameters: DependencyParameters) {
        // deferred resolution of a circular dependency
        content = DependencyResolver.resolve(with: parameters)
    }
}

class Dependency2: Injectable {
    let parameters: DependencyParameters
    
    required init(with parameters: DependencyParameters) {
        self.parameters = parameters
        print("from Dependency2(\(UUID().uuidString)), parameters: \(parameters)")
    }
}

class Content: Injectable {
    @Inject var dependency: Dependency1
    
    required init(with parameters: DependencyParameters) {
        print("from Content(\(UUID().uuidString))")
    }
    
    func doSomething() {
        print("Content did something")
    }
}

class ProductionDependency: Injectable {
    required init(with parameters: DependencyParameters) {
        print("ProductionDependency initialized")
    }
}

class MockedDependency: ProductionDependency {
    required init(with parameters: DependencyParameters) {
        super.init(with: parameters)
        print("MockedDependency initialized")
    }
}
