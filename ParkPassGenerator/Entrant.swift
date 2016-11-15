//
//  Area.swift
//  ParkPassGenerator
//
//  Created by Alexey Papin on 15.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

// Areable

enum Area: CustomStringConvertible {
    case Amusement
    case Kitchen
    case RideControl
    case Maintenance
    case Office
    
    var description: String {
        switch self {
        case .Amusement: return "Amusement Areas"
        case .Kitchen: return "Kitchen Areas"
        case .RideControl: return "Ride Control Areas"
        case .Maintenance: return "Maintenance Areas"
        case .Office: return "Office Areas"
        }
    }
}

enum Access: CustomStringConvertible {
    case AllRides
    case SkipAllRideLines
    
    var description: String {
        switch self {
        case .AllRides: return "Access all rides"
        case .SkipAllRideLines: return "Skip all ride lines"
        }
    }
}

typealias Percent = Int
struct Discount: CustomStringConvertible {
    let food: Percent
    let merchant: Percent
    
    var description: String {
        return "\(food)% discount on food, \(merchant)% discount on merchandise"
    }
}

enum Requirements: CustomStringConvertible {
    case FirstName
    case LastName
    case StreetAddress
    case City
    case State
    case ZipCode
    case DateOfBirth
    
    var description: String {
        switch self {
        case .FirstName: return "First Name"
        case .LastName: return "Last Name"
        case .City: return "City"
        case .DateOfBirth: return "Date of Birth"
        case .State: return "State"
        case .StreetAddress: return "Street Address"
        case .ZipCode: return "Zip Code"
        }
    }
}

// Protocols

protocol Entrantable {
    var type: EntrantType { get }
}

protocol Areable: Entrantable {
    var areas: [Area] { get }
}

protocol Accessable: Entrantable {
    var access: [Access] { get }
}

protocol Discountable: Entrantable {
    var discount: Discount { get }
}

protocol Requirementable: Entrantable {
    var requirements: [Requirements] { get }
}

// Extensions

extension Areable {
    var areas: [Area] {
        switch self.type {
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

extension Accessable {
    var access: [Access] {
        switch self.type {
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

extension Discountable {
    var discount: Discount {
        switch self.type {
        case .GuestClassic: return Discount(food: 0, merchant: 0)
        case .GuestVip: return Discount(food: 10, merchant: 20)
        case .GuestChild: return Discount(food: 0, merchant: 0)
        case .EmployeeFood: return Discount(food: 15, merchant: 25)
        case .EmployeeRide: return Discount(food: 15, merchant: 25)
        case .EmployeeMaintenance: return Discount(food: 15, merchant: 25)
        case .Manager: return Discount(food: 25, merchant: 25)
        }
    }
}

extension Requirementable {
    var requirements: [Requirements] {
        switch self.type {
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

class Entrant: Areable, Accessable, Discountable, Requirementable, CustomStringConvertible {
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
    
    var description: String {
        return "\(type)" // FIXME
    }
}

































