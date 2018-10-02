//
//  DependencyInjection.swift
//  Palette
//
//  Created by Saoirse on 10/2/18.
//  Copyright © 2018 Gaia Inc. All rights reserved.
//

import Foundation

// MARK:- Dependency Protocol.
protocol Dependency {
    func resolveWebService() -> WebServiceInterface
}

// MARK:- Core Dependency.
// List of concrete dependencies.
class CoreDependency: Dependency {
    func resolveWebService() -> WebServiceInterface {
        return WebServiceProvider(urlSession: URLSession.shared)
    }
}

// MARK:- Dependency Injector
struct DependencyInjector {
    static var dependencies: Dependency = CoreDependency()
    private init() { }
}

// Attach to any type for exposing the dependency container
protocol HasDependencies {
    var dependencies: Dependency { get }
}
extension HasDependencies {
    var dependencies: Dependency {
        return DependencyInjector.dependencies
    }
}

// MARK:- APP Dependency.
class AppDependency: CoreDependency {
    
}

