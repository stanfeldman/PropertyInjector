//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

import PropertyInjector

class DependencyManager {
    init() {
        DependencyResolver.register {
            $0.factory(Dependency.self, Dependency())
            $0.singleton(SubDependency1.self) {
                return SubDependency1()
            }
            $0.factory(SubDependency2.self) { parameters in
                return SubDependency2(name: parameters["name"] as! String)
            }
        }
    }
}

