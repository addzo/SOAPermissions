//
//  PermissionsService.swift
//  SOAPermissions
//
//  Created by William Repenning on 5/26/20.
//  Copyright © 2020 William Repenning. All rights reserved.
//

import Foundation
import UIKit

private let permissionsServiceName = "PermissionsService"

extension ServiceRegistryImplementation {
    var permissionsService: PermissionsService {
        get {
            return serviceWith(name: permissionsServiceName) as! PermissionsService
        }
    }
}

protocol PermissionsService: Service {
    func usePermissions(_ content: Any, withActivityItems activityItems: [Any], presentingController: UIViewController)
}

extension PermissionsService {
    var serviceName: String { get {return permissionsServiceName} }
    
   // custom functions
}

internal class SomeServiceImplementation: PermissionsService {
    func usePermissions(_ content: Any, withActivityItems activityItems: [Any], presentingController: UIViewController) {
        //
    }
    
    internal static func register() {
        ServiceRegistry.add(service: LazyService(serviceName: permissionsServiceName) { SomeServiceImplementation() })
    }
}
