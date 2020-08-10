//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

/**
 Dependency resolution strategies.
 */
public enum DependencyResolutionStrategy {
    
    /// Dependency will be recreated every time it's injected.
    case factory
    
    /// There will be only one instance of the dependency class.
    case singleton
}
