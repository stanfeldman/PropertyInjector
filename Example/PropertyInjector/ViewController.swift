//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

import PropertyInjector
import UIKit

class ViewController: UIViewController {
    
    @Inject var smallContent: Content
    @Inject var mediumContent: Content
    @Inject private var dependency: Dependency1
    @Inject(parameters: ["param1": 542]) var dependency2: Dependency2

    override func viewDidLoad() {
        super.viewDidLoad()
        print("from ViewController(\(UUID().uuidString))")
        let _: Dependency2 = DependencyResolver.shared.resolve(with: ["uuid": UUID().uuidString])
    }

}

