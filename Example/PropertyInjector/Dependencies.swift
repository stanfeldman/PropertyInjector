//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

import PropertyInjector

class Dependency {
    @Inject var sub1: SubDependency1
    
    func doSomething() {
        print("Content did something")
        _ = sub1.id
        let sub2: SubDependency2 = DependencyResolver.resolve(with: ["name": "Boris"])
        sub2.doSomething()
    }
    
    func helpFromParent() {
        print("Parent helped")
    }
}

class SubDependency1: Identifiable {}

class SubDependency2: Identifiable {
    init(name: String) {
        super.init()
        print("from SubDependency2(\(id)): \(name)")
    }
    
    @Inject private var parent: Dependency
    
    func doSomething() {
        parent.helpFromParent()
        print("SubDependency1 did something")
    }
}

class Identifiable {
    let id = UUID().uuidString
    
    init() {
        print("from \(String(reflecting: self))(\(id))")
    }
}
