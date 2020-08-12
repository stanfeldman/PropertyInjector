//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

import PropertyInjector
import UIKit

class ViewController: UIViewController {
    
    @Inject private var dependency: Dependency

    override func viewDidLoad() {
        super.viewDidLoad()
        dependency.doSomething()
    }
}

