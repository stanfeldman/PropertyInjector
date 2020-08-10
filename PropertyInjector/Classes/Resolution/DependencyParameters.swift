//
//  PropertyInjector
//  Created by Stan Feldman on 10/8/20.
//  Copyright (c) 2020 Stan Feldman. All rights reserved.
//

/**
 A generic parameters bundle which can be passed to a dependency as input.
 */
public typealias DependencyParameters = [String: Any?]

/**
 Empty dependency parameters.
 */
public let defaultDependencyParameters: DependencyParameters = [:]
