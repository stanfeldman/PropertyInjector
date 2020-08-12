//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

/**
 Helper class providing registering methods for various strategies of dependency resolution.
 */
public class DependencyRegistrar: Applicable {
    
    public func factory<Dependency: Injectable>(type: Dependency.Type) {
        DependencyResolver.register(type: type, resolutionStrategy: .factory)
    }
    
    public func singleton<Dependency: Injectable>(type: Dependency.Type) {
        DependencyResolver.register(type: type, resolutionStrategy: .singleton)
    }
}
