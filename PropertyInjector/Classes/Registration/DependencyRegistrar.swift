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
    
    /// Register `initializer` as `Dependency` which will be created every time it's resolved.
    public func factory<Dependency>(_ type: Dependency.Type, _ initializer: @autoclosure @escaping () -> Dependency) {
        DependencyResolver.register(type: type, resolutionStrategy: .factory, initializer: initializer)
    }
    
    /// Register `initializer` as `Dependency` which will be created every time it's resolved.
    public func factory<Dependency>(_ type: Dependency.Type, _ initializer: @escaping () -> Dependency) {
        DependencyResolver.register(type: type, resolutionStrategy: .factory, initializer: initializer)
    }
    
    /// Register `initializer` with the type returned from it which will be created every time it's resolved.
    public func factory<Dependency>(_ initializer: @autoclosure @escaping () -> Dependency) {
        DependencyResolver.register(type: Dependency.self, resolutionStrategy: .factory, initializer: initializer)
    }
    
    /// Register `initializer` with the type returned from it which will be created every time it's resolved.
    public func factory<Dependency>(_ initializer: @escaping () -> Dependency) {
        DependencyResolver.register(type: Dependency.self, resolutionStrategy: .factory, initializer: initializer)
    }
    
    /// Register `initializer` as `Dependency` which will be created only one time and then reused when resolved.
    public func singleton<Dependency>(_ type: Dependency.Type, _ initializer: @autoclosure @escaping () -> Dependency) {
        DependencyResolver.register(type: type, resolutionStrategy: .singleton, initializer: initializer)
    }
    
    /// Register `initializer` as `Dependency` which will be created only one time and then reused when resolved.
    public func singleton<Dependency>(_ type: Dependency.Type, _ initializer: @escaping () -> Dependency) {
        DependencyResolver.register(type: type, resolutionStrategy: .singleton, initializer: initializer)
    }
    
    /// Register `initializer` with the type returned which will be created only one time and then reused when resolved.
    public func singleton<Dependency>(_ initializer: @autoclosure @escaping () -> Dependency) {
        DependencyResolver.register(type: Dependency.self, resolutionStrategy: .singleton, initializer: initializer)
    }
    
    /// Register `initializer` with the type returned which will be created only one time and then reused when resolved.
    public func singleton<Dependency>(_ initializer: @escaping () -> Dependency) {
        DependencyResolver.register(type: Dependency.self, resolutionStrategy: .singleton, initializer: initializer)
    }
    
    // MARK: - with parameters
    
    /// Register `initializer` with parameters as `Dependency` which will be created every time it's resolved.
    public func factory<Dependency>(_ type: Dependency.Type, _ initializer: @escaping (DependencyParameters) -> Dependency) {
        DependencyResolver.register(type: type, resolutionStrategy: .factory, initializer: initializer)
    }
    
    /// Register `initializer` with parameters with the type returned from it which will be created every time it's resolved.
    public func factory<Dependency>(_ initializer: @escaping (DependencyParameters) -> Dependency) {
        DependencyResolver.register(type: Dependency.self, resolutionStrategy: .factory, initializer: initializer)
    }
    
    /// Register `initializer` with parameters as `Dependency` which will be created only one time and then reused when resolved.
    public func singleton<Dependency>(_ type: Dependency.Type, _ initializer: @escaping (DependencyParameters) -> Dependency) {
        DependencyResolver.register(type: type, resolutionStrategy: .singleton, initializer: initializer)
    }
    
    /// Register `initializer` with parameters with the type returned which will be created only one time and then reused when resolved.
    public func singleton<Dependency>(_ initializer: @escaping (DependencyParameters) -> Dependency) {
        DependencyResolver.register(type: Dependency.self, resolutionStrategy: .singleton, initializer: initializer)
    }
}
