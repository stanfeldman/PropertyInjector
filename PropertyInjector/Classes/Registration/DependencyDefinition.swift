//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

/**
 Internal class holding a definition of a dependency when it's registered in the resolver.
 */
class DependencyDefinition {

    let type: Injectable.Type
    let resolutionStrategy: DependencyResolutionStrategy
    
    private var existingObject: Injectable?
    
    init(type: Injectable.Type, resolutionStrategy: DependencyResolutionStrategy) {
        self.type = type
        self.resolutionStrategy = resolutionStrategy
    }
    
    func resolve(resolver: DependencyResolver, parameters: DependencyParameters) -> Injectable {
        if resolutionStrategy == .singleton {
            let objectToReturn = existingObject ?? type.init(from: resolver, with: parameters)
            existingObject = objectToReturn
            return objectToReturn
        } else {
            return type.init(from: resolver, with: parameters)
        }
    }
}
