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
    
    private static var dependencyDefinitions = [String: DependencyDefinition]()

    private init() {}
    
    public static func register(_ closure: @escaping (DependencyRegistrar) -> Void) {
        DependencyRegistrar().apply(closure)
    }
    
    public static func register<Dependency: Injectable>(type: Dependency.Type, resolutionStrategy: DependencyResolutionStrategy) {
        let key = keyFor(type: Dependency.self)
        self.dependencyDefinitions[key] = DependencyDefinition(type: type, resolutionStrategy: resolutionStrategy)
    }
    
    public static func resolve<Dependency: Injectable>(with parameters: DependencyParameters = defaultDependencyParameters) -> Dependency {
        let key = keyFor(type: Dependency.self)
        if let injectable = self.dependencyDefinitions[key]?.resolve(with: parameters) as? Dependency {
            return injectable
        } else {
            fatalError("\(key) has not been added as an injectable object.")
        }
    }
    
    private static func keyFor<Dependency: Injectable>(type: Dependency.Type) -> String {
        return String(reflecting: Dependency.self)
    }
}
