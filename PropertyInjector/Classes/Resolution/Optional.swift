//
//  PropertyInjector
//  Created by Stan Feldman on 10/09/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

protocol OptionalProtocol {
    
    /// Metatype value for the wrapped type.
    static var wrappedType: Any.Type { get }
}

extension Optional : OptionalProtocol {
    
    static var wrappedType: Any.Type { return Wrapped.self }
}
