//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

import Foundation

/**
 Dependency resolution strategies.
 */
public enum DependencyResolutionStrategy {
    
    /// Dependency will be recreated every time it's injected.
    case factory
    
    /// There will be only one instance of the dependency class.
    case singleton
}

/**
 Singleton used to register and resolve your dependencies.
 ```
 DependencyResolver.shared.register {
     $0.factory(type: MyDependency.self)
 }
 ```
 */
public class DependencyResolver {
    private var dependencyDefinitions = [String: DependencyDefinition]()
    
    public static let shared = DependencyResolver()
    private init() {}
    
    public func register(_ closure: @escaping (DependencyRegistrar) -> Void) {
        DependencyRegistrar().apply(closure)
    }
    
    public func register<Dependency: Injectable>(type: Dependency.Type, resolutionStrategy: DependencyResolutionStrategy, initializer: DependencyInitializer? = nil) {
        let key = keyFor(type: Dependency.self)
        dependencyDefinitions[key] = DependencyDefinition(type: type, resolutionStrategy: resolutionStrategy, initializer: initializer)
    }
    
    public func resolve<Dependency: Injectable>(parameters: DependencyParameters) -> Dependency {
        let key = keyFor(type: Dependency.self)
        if let injectable = dependencyDefinitions[key]?.resolve(parameters: parameters) as? Dependency {
            return injectable
        } else {
            fatalError("\(key) has not been added as an injectable object.")
        }
    }
    
    private func keyFor<Dependency: Injectable>(type: Dependency.Type) -> String {
        return String(reflecting: Dependency.self)
    }
}

/**
 Helper class providing registering methods for various strategies of dependency resolution.
 */
public class DependencyRegistrar: Applicable {
    
    public func factory<Dependency: Injectable>(type: Dependency.Type, initializer: DependencyInitializer? = nil) {
        DependencyResolver.shared.register(type: type, resolutionStrategy: .factory, initializer: initializer)
    }
    
    public func singleton<Dependency: Injectable>(type: Dependency.Type, initializer: DependencyInitializer? = nil) {
        DependencyResolver.shared.register(type: type, resolutionStrategy: .singleton, initializer: initializer)
    }
}
