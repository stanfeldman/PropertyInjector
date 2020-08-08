//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

import Foundation

/**
 A protocol with a single `apply(_:)` method.
 */
protocol Applicable {}

extension Applicable {
    
    /// Call methods of a closure from inside an object.
    func apply(_ closure: (Self) -> Void) {
        closure(self)
    }
}
