//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

/**
 Singleton used to register and resolve your dependencies.
 ```
 DependencyResolver.shared.register {
     $0.singleton(MyDependency.self, MyDependency())
 }
 ```
 */
public class DependencyResolver {
    
    private static var dependencyDefinitions = [String: DependencyDefinition]()
    private static var dependencyDefinitionsWithParameters = [String: DependencyDefinitionWithParameters]()
    private static var sharedInstances = [String: Any]()

    private init() {}
    
    public static func register(_ closure: @escaping (DependencyRegistrar) -> Void) {
        DependencyRegistrar().apply(closure)
    }
    
    public static func register<Dependency>(type: Dependency.Type, resolutionStrategy: DependencyResolutionStrategy, initializer: @escaping () -> Dependency) {
        let key = keyFor(type: type)
        self.dependencyDefinitions[key] = DependencyDefinition(resolutionStrategy: resolutionStrategy, initializer: initializer)
    }
    
    public static func register<Dependency>(type: Dependency.Type, resolutionStrategy: DependencyResolutionStrategy, initializer: @escaping (DependencyParameters) -> Dependency) {
        let key = keyFor(type: type)
        self.dependencyDefinitionsWithParameters[key] = DependencyDefinitionWithParameters(resolutionStrategy: resolutionStrategy, initializer: initializer)
    }
    
    public static func resolve<Dependency>() -> Dependency {
        let key = keyFor(type: Dependency.self)
        guard let dependencyDefinition = self.dependencyDefinitions[key] else {
            fatalError("\(key) has not been added as an injectable object.")
        }
        switch dependencyDefinition.resolutionStrategy {
        case .factory:
            if let dependency = dependencyDefinition.initializer() as? Dependency {
                return dependency
            } else {
                fatalError("\(key) has not been added as an injectable object.")
            }
            
        case .singleton:
            if let dependency = self.sharedInstances[key] as? Dependency {
                return dependency
            } else if let dependency = dependencyDefinition.initializer() as? Dependency {
                self.sharedInstances[key] = dependency
                return dependency
            } else {
                fatalError("\(key) has not been added as an injectable object.")
            }
        }
    }
    
    public static func resolve<Dependency>(with parameters: DependencyParameters) -> Dependency {
        let key = keyFor(type: Dependency.self)
        guard let dependencyDefinition = self.dependencyDefinitionsWithParameters[key] else {
            fatalError("\(key) has not been added as an injectable object.")
        }
        switch dependencyDefinition.resolutionStrategy {
        case .factory:
            if let dependency = dependencyDefinition.initializer(parameters) as? Dependency {
                return dependency
            } else {
                fatalError("\(key) has not been added as an injectable object.")
            }
            
        case .singleton:
            if let dependency = self.sharedInstances[key] as? Dependency {
                return dependency
            } else if let dependency = dependencyDefinition.initializer(parameters) as? Dependency {
                self.sharedInstances[key] = dependency
                return dependency
            } else {
                fatalError("\(key) has not been added as an injectable object.")
            }
        }
    }
    
    private static func keyFor<Dependency>(type: Dependency.Type) -> String {
        return String(reflecting: Dependency.self)
    }
}
