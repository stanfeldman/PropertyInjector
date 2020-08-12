//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

/**
 Helper class providing registering methods for various strategies of dependency resolution.
 */
public class DependencyRegistrar: Applicable {
    
    // MARK: - no parameters
    
    public func factory<Dependency>(_ type: Dependency.Type, _ initializer: @autoclosure @escaping () -> Dependency) {
        DependencyResolver.register(type: type, resolutionStrategy: .factory, initializer: initializer)
    }
    
    public func factory<Dependency>(_ type: Dependency.Type, _ initializer: @escaping () -> Dependency) {
        DependencyResolver.register(type: type, resolutionStrategy: .factory, initializer: initializer)
    }
    
    public func singleton<Dependency>(_ type: Dependency.Type, _ initializer: @autoclosure @escaping () -> Dependency) {
        DependencyResolver.register(type: type, resolutionStrategy: .singleton, initializer: initializer)
    }
    
    public func singleton<Dependency>(_ type: Dependency.Type, _ initializer: @escaping () -> Dependency) {
        DependencyResolver.register(type: type, resolutionStrategy: .singleton, initializer: initializer)
    }
    
    // MARK: - with parameters
    
    public func factory<Dependency>(_ type: Dependency.Type, _ initializer: @escaping (DependencyParameters) -> Dependency) {
        DependencyResolver.register(type: type, resolutionStrategy: .factory, initializer: initializer)
    }
    
    public func singleton<Dependency>(_ type: Dependency.Type, _ initializer: @escaping (DependencyParameters) -> Dependency) {
        DependencyResolver.register(type: type, resolutionStrategy: .singleton, initializer: initializer)
    }
}
