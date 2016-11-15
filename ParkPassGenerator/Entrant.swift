//
//  Area.swift
//  ParkPassGenerator
//
//  Created by Alexey Papin on 15.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

// Areable

enum Area {
    case Amusement
    case Kitchen
    case RideControl
    case Maintenance
    case Office
    
    func area(type: EntrantType) -> [Area] {
        switch type {
        case .GuestClassic: return [.Amusement]
        case .GuestVip: return [.Amusement]
        case .GuestChild: return [.Amusement]
        case .EmployeeFood: return [.Amusement, .Kitchen]
        case .EmployeeRide: return [.Amusement, .RideControl]
        case .EmployeeMaintenance: return [.Amusement, .Kitchen, .RideControl, .Maintenance]
        case .Manager: return [.Amusement, .Kitchen, .RideControl, .Maintenance, .Office]
        }
    }
}

protocol Areable {
    func restrictedAreas(for type: EntrantType) -> [Area]
}

extension Areable {
    func restrictedAreas(for type: EntrantType) -> [Area] {
        switch type {
        case .GuestClassic: return [.Amusement]
        case .GuestVip: return [.Amusement]
        case .GuestChild: return [.Amusement]
        case .EmployeeFood: return [.Amusement, .Kitchen]
        case .EmployeeRide: return [.Amusement, .RideControl]
        case .EmployeeMaintenance: return [.Amusement, .Kitchen, .RideControl, .Maintenance]
        case .Manager: return [.Amusement, .Kitchen, .RideControl, .Maintenance, .Office]
        }
    }
}

// Accessable

enum Access {
    case AllRides
    case SkipAllRideLines
}

protocol Accessable {
    func restrictedAccess(for type: EntrantType) -> [Access]
}

extension Accessable {
    func restrictedAccess(for type: EntrantType) -> [Access] {
        switch type {
        case .GuestClassic: return [.AllRides]
        case .GuestVip: return [.AllRides, .SkipAllRideLines]
        case .GuestChild: return [.AllRides]
        case .EmployeeFood: return [.AllRides]
        case .EmployeeRide: return [.AllRides]
        case .EmployeeMaintenance: return [.AllRides]
        case .Manager: return [.AllRides]
        }
    }
}

// Discountable

typealias Percent = Int
typealias Discount = (foodDiscount: Percent, merchantDiscount: Percent)

protocol Discountable {
    func discount(for type: EntrantType) -> Discount
}

extension Discountable {
    func discount(for type: EntrantType) -> Discount {
        switch type {
        case .GuestClassic: return (foodDiscount: 0, merchantDiscount: 0)
        case .GuestVip: return (foodDiscount: 10, merchantDiscount: 20)
        case .GuestChild: return (foodDiscount: 0, merchantDiscount: 0)
        case .EmployeeFood: return (foodDiscount: 15, merchantDiscount: 25)
        case .EmployeeRide: return (foodDiscount: 15, merchantDiscount: 25)
        case .EmployeeMaintenance: return (foodDiscount: 15, merchantDiscount: 25)
        case .Manager: return (foodDiscount: 25, merchantDiscount: 25)
        }
    }
}

// Requirementsable

enum Requirements {
    case FirstName
    case LastName
    case StreetAddress
    case City
    case State
    case ZipCode
    case DateOfBirth
}

protocol Requirementsable {
    func requirements(for type: EntrantType) -> [Requirements]
}

extension Requirementsable {
    func requirements(for type: EntrantType) -> [Requirements] {
        switch type {
        case .GuestClassic: return []
        case .GuestVip: return []
        case .GuestChild: return [.DateOfBirth]
        case .EmployeeFood: return [.FirstName, .LastName, .StreetAddress, .City, .State, .ZipCode]
        case .EmployeeRide: return [.FirstName, .LastName, .StreetAddress, .City, .State, .ZipCode]
        case .EmployeeMaintenance: return [.FirstName, .LastName, .StreetAddress, .City, .State, .ZipCode]
        case .Manager: return [.FirstName, .LastName, .StreetAddress, .City, .State, .ZipCode]
        }
    }
}

// Entrant

enum EntrantType {
    case GuestClassic
    case GuestVip
    case GuestChild
    case EmployeeFood
    case EmployeeRide
    case EmployeeMaintenance
    case Manager
}

class Entrant: Areable, Accessable, Discountable, Requirementsable {
    let type: EntrantType
    
    let firstName: String?
    let lastName: String?
    let streetAddress: String?
    let city: String?
    let state: String?
    let zipCode: String?
    let dateOfBirth: Date?
    
    init(type: EntrantType, firstName: String? = nil, lastName: String? = nil, streetAddress: String? = nil, city: String? = nil, state: String? = nil, zipCode: String? = nil, dateOfBirth: Date? = nil) {
        self.type = type
        
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.dateOfBirth = dateOfBirth
    }
}

































