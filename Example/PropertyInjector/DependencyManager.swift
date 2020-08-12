//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

import PropertyInjector

class DependencyManager {
    init() {
        DependencyResolver.shared.register {
            $0.singleton(type: Content.self)
            $0.singleton(type: Dependency1.self)
            $0.factory(type: Dependency2.self)
            $0.factory(type: MockedDependency.self as ProductionDependency.Type)
        }
    }
}

