//
//  PropertyInjector
//  Created by Stan Feldman on 08/08/2020.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

public protocol Injectable {
    init(parameters: DependencyParameters)
}

@propertyWrapper
public struct Inject<T: Injectable> {
    public let wrappedValue: T
    
    public init(parameters: DependencyParameters = [:]) {
        wrappedValue = DependencyResolver.shared.resolve(parameters: parameters)
    }
}
