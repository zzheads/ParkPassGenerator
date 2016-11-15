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
        case .GuestClassic, .GuestVip, .GuestChild: return [.Amusement]
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
        case .GuestVip: return [.AllRides, .SkipAllRideLines]
        default: return [.AllRides]
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
        case .GuestClassic, .GuestVip:
            return []
        case .GuestChild:
            return [.DateOfBirth]
        case .EmployeeFood, .EmployeeRide, .EmployeeMaintenance, .Manager:
            return [.FirstName, .LastName, .StreetAddress, .City, .State, .ZipCode]
        }
    }
}

// Errors

enum EntrantError: Error {
    case noFirstName
    case noLastName
    case noStreetAddress
    case noCity
    case noState
    case noZipCode
    case noDateOfBirth
    
    var rawValue: String {
        switch self {
        case .noFirstName: return "First Name"
        case .noLastName: return "Last Name"
        case .noStreetAddress: return "Street Address"
        case .noCity: return "City"
        case .noState: return "State"
        case .noZipCode: return "Zip Code"
        case .noDateOfBirth: return "Date of Birth"
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
    
    var fullName: String? {
        if let firstName = self.firstName {
            if let lastName = self.lastName {
                return "\(firstName) \(lastName)"
            } else {
                return "\(firstName)"
            }
        }
        if let lastName = self.lastName {
            return "\(lastName)"
        }
        return nil
    }
    
    var address: String? {
        var address: String = ""
        if let streetAddress = self.streetAddress {
            address += streetAddress + ", "
        }
        if let city = self.city {
            address += city + ", "
        }
        if let state = self.state {
            address += state + ", "
        }
        if let zipCode = self.zipCode {
            address += zipCode
        }
        if address.characters.count > 0 {
            return address
        } else {
            return nil
        }
    }
    
    var dateOfBirthAsString: String? {
        if let dateOfBirth = self.dateOfBirth {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            return dateFormatter.string(from: dateOfBirth)
        } else {
            return nil
        }
    }
    
    init(type: EntrantType, firstName: String? = nil, lastName: String? = nil, streetAddress: String? = nil, city: String? = nil, state: String? = nil, zipCode: String? = nil, dateOfBirth: Date? = nil) throws {
        self.type = type
        
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.dateOfBirth = dateOfBirth
        
        if self.requirements.contains(.FirstName) && firstName == nil {
            throw EntrantError.noFirstName
        }
        if self.requirements.contains(.LastName) && lastName == nil {
            throw EntrantError.noLastName
        }
        if self.requirements.contains(.StreetAddress) && streetAddress == nil {
            throw EntrantError.noStreetAddress
        }
        if self.requirements.contains(.City) && city == nil {
            throw EntrantError.noCity
        }
        if self.requirements.contains(.State) && state == nil {
            throw EntrantError.noState
        }
        if self.requirements.contains(.ZipCode) && zipCode == nil {
            throw EntrantError.noZipCode
        }
        if self.requirements.contains(.DateOfBirth) && dateOfBirth == nil {
            throw EntrantError.noDateOfBirth
        }
    }
    
    var description: String {
        var descriptionString: String = ""
        if let fullName = self.fullName {
            descriptionString += "Name: \(fullName), "
        }
        if let address = self.address {
            descriptionString += "Address: \(address), "
        }
        if let date = self.dateOfBirthAsString {
            descriptionString += "Born: \(date)"
        }
        return descriptionString // FIXME
    }
}

































