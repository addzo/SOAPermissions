//
//  ServiceTemplate.swift
//  SOAPermissions
//
//  Created by William Repenning on 5/26/20.
//  Copyright © 2020 William Repenning. All rights reserved.
//

/**
 This is just a template to keep it straight in my head.
 This will also change as Scott and I discuss this I'm sure
 */

import Foundation

private struct ServiceTemplateName {
    static let serviceName = "Name of service"
}

extension ServiceRegistryImplementation {
    var serviceTemplate: ServiceTemplate {
        get {
            return serviceWith(name: ServiceTemplateName.serviceName) as! ServiceTemplate // Force unwrap?
        }
    }
}

protocol ServiceTemplate: Service {
    func someServiceFunction()
}

extension ServiceTemplate {
    var serviceName: String {
        get {
            return ServiceTemplateName.serviceName
        }
    }
    
    func someServiceFunction() {
        //
    }
}

internal class ServiceTemplateImplementation : ServiceTemplate {
    // Only define one register function.
    static func register() {
        ServiceTemplateImplementation().register()
    }

    // Register the service as a lazy service.
//    static func register() {
//        ServiceRegistry.add(service: LazyService(serviceName: ServiceTemplateName.serviceName, serviceGetter: { ServiceTemplateImplementation() }))
//    }
}
