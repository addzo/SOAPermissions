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
    func Granted() -> [String]
    func NotGranted() -> [String]
}

extension PermissionsService {
    var serviceName: String { get {return permissionsServiceName} }
}

internal class NotificationPermissionsEvaluator: PermissionsService {
    func Granted() -> [String] {
        // Just here as a place holder to understand what you meant by looping through the arrays
        return ["manager_calls", "unlock"]
    }
    
    func NotGranted() -> [String] {
        // Just here as a place holder to understand what you meant by looping through the arrays
        return ["whitelist", "seatbelt"]
    }
    
    internal static func register() {
        ServiceRegistry.add(service: LazyService(serviceName: permissionsServiceName) { NotificationPermissionsEvaluator() })
    }
}

internal class LocationPermissionsEvaluator: PermissionsService {
    func Granted() -> [String] {
        // Just here as a place holder to understand what you meant by looping through the arrays
        return ["one", "three"]
    }
    
    func NotGranted() -> [String] {
        // Just here as a place holder to understand what you meant by looping through the arrays
        return ["four", "two"]
    }
    
    internal static func register() {
        ServiceRegistry.add(service: LazyService(serviceName: permissionsServiceName) { LocationPermissionsEvaluator() })
    }
}
