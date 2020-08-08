//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

import PropertyInjector

class Dependency1: Injectable {
    required init(parameters: DependencyParameters) {
        print("from Dependency1(\(UUID().uuidString))")
    }
}

class Dependency2: Injectable {
    required init(parameters: DependencyParameters) {
        print("from Dependency2(\(UUID().uuidString)), parameters: \(parameters)")
    }
}

class Content: Injectable {
    @Inject var dependency: Dependency1
    
    required init(parameters: DependencyParameters) {
        print("from Content(\(UUID().uuidString))")
    }
}
