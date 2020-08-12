//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

import PropertyInjector
import UIKit

class ViewController: UIViewController {
    
    @Inject var smallContent: Content
    @Inject private var dependency: Dependency1
    @Inject(with: ["param1": 542]) var dependency2: Dependency2
    @Inject var anotherDependency: ProductionDependency
    
    @LazyInject private var mediumContent: Content

    override func viewDidLoad() {
        super.viewDidLoad()
        print("from ViewController(\(UUID().uuidString))")
        let _: Dependency2 = DependencyResolver.resolve(with: ["uuid": UUID().uuidString])
        
        mediumContent.doSomething()
    }

}

