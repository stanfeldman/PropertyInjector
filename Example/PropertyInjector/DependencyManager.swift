//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

import PropertyInjector

let dependencyResolver = DependencyResolver.shared

class DependencyManager {
    init() {
        dependencyResolver.register {
            $0.factory(type: Content.self)
            $0.singleton(type: Dependency1.self)
            $0.factory(type: Dependency2.self) { parameters in
               print("Do some extra init for Dependency2")
               return Dependency2(parameters: parameters)
           }
        }
        
        // or
        // dependencyResolver.register(type: Content.self, resolutionStrategy: .factory)
        // dependencyResolver.register(type: Dependency1.self, resolutionStrategy: .singleton)
    }
}

