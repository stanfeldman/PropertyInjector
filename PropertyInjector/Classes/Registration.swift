//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

import Foundation

public typealias DependencyParameters = [String: Any?]

public typealias DependencyInitializer = (DependencyParameters) -> Injectable

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
