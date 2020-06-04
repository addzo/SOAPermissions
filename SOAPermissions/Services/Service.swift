//
//  Service.swift
//  SOAPermissions
//
//  Created by William Repenning on 5/25/20.
//  Copyright © 2020 William Repenning. All rights reserved.
//

import Foundation

let ServiceRegistry = ServiceRegistryImplementation()

protocol Service {
    // Every service should have a unique name
    var serviceName: String { get }
    
    // Every service needs a way to register itself
    func register()
}

extension Service {
    // Default implementation for a sdervice to register itself
    internal func register() {
        ServiceRegistry.add(service: self)
    }
}

final class LazyService: Service {
    internal let serviceName: String
    
    // Accessor instantiates the srevice the first time this is called
    internal lazy var serviceGetter: (() -> Service) = {
        if self.service == nil {
            self.service = self.implementationGetter()
        }
        return self.service!
    }
    
    // Reference to the closure that instantiates the service.
    private var implementationGetter: (() -> Service)
    
    // Reference to the instantiated service
    private var service: Service? = nil
    
    // Initializer takes a name and a closure that will instantiate the service.
    internal init(serviceName : String, serviceGetter : @escaping (() -> Service)) {
        self.serviceName = serviceName
        self.implementationGetter = serviceGetter
    }
}

struct ServiceRegistryImplementation {
    private static var serviceDictionary: [String : LazyService] = [:]
    
    internal func add(service: LazyService) {
        if ServiceRegistryImplementation.serviceDictionary[service.serviceName] != nil {
            print("ERROR: registering service \(service.serviceName) and it already exists.")
        }
        ServiceRegistryImplementation.serviceDictionary[service.serviceName] = service
    }
    
    internal func add (service: Service) {
        add(service: LazyService(serviceName: service.serviceName, serviceGetter: { service }))
    }
    
    internal func serviceWith(name: String) -> Service {
        guard let resolvedService = ServiceRegistryImplementation().get(serviceWithName: name) else {
            fatalError("Error: Service \(name) is not registered with the ServiceRegistry.")
        }
        return resolvedService
    }
    
    private func  get(serviceWithName name: String) -> Service? {
        return ServiceRegistryImplementation.serviceDictionary[name]?.serviceGetter()
    }
}
