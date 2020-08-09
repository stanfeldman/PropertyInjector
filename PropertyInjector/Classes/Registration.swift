//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

import Foundation

/**
 A generic parameters bundle which can be passed to a dependency as input.
 */
public typealias DependencyParameters = [String: Any?]

/**
 Every dependency class is expected to implement this initializer which is called when the dependency is created.
 */
public typealias DependencyInitializer = (DependencyParameters) -> Injectable

/**
 Internal class holding a definition of a dependency when it's registered in the resolver.
 */
class DependencyDefinition {

    let type: Injectable.Type
    let resolutionStrategy: DependencyResolutionStrategy
    let initializer: DependencyInitializer
    
    private var existingObject: Injectable?
    
    init(type: Injectable.Type, resolutionStrategy: DependencyResolutionStrategy, initializer: DependencyInitializer? = nil) {
        self.type = type
        self.resolutionStrategy = resolutionStrategy
        self.initializer = initializer ?? type.init
    }
    
    func resolve(parameters: DependencyParameters) -> Injectable {
        if resolutionStrategy == .singleton {
            let objectToReturn = existingObject ?? initializer(parameters)
            existingObject = objectToReturn
            return objectToReturn
        } else {
            return initializer(parameters)
        }
    }
}
