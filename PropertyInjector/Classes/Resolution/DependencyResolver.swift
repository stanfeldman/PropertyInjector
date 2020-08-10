//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

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
    
    public func register<Dependency: Injectable>(type: Dependency.Type, resolutionStrategy: DependencyResolutionStrategy) {
        let key = keyFor(type: Dependency.self)
        dependencyDefinitions[key] = DependencyDefinition(type: type, resolutionStrategy: resolutionStrategy)
    }
    
    public func resolve<Dependency: Injectable>(with parameters: DependencyParameters = defaultDependencyParameters) -> Dependency {
        let key = keyFor(type: Dependency.self)
        if let injectable = dependencyDefinitions[key]?.resolve(resolver: self, parameters: parameters) as? Dependency {
            return injectable
        } else {
            fatalError("\(key) has not been added as an injectable object.")
        }
    }
    
    private func keyFor<Dependency: Injectable>(type: Dependency.Type) -> String {
        return String(reflecting: Dependency.self)
    }
}
