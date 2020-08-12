//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

/**
 Definition of a dependency when it's registered in the resolver.
 */
struct DependencyDefinition {
    let resolutionStrategy: DependencyResolutionStrategy
    let initializer: DependencyInitializer
}

/**
Definition of a dependency with parameters when it's registered in the resolver.
*/
struct DependencyDefinitionWithParameters {
    let resolutionStrategy: DependencyResolutionStrategy
    let initializer: DependencyInitializerWithParameters
}

typealias DependencyInitializer = () -> Any
typealias DependencyInitializerWithParameters = (DependencyParameters) -> Any
