//
//  UserInput.swift
//  ParkPassGenerator
//
//  Created by Alexey Papin on 15.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

// This dictionary will fake user input

typealias DataForEntrantInitialization = [String: String]
class UserInput {
    let input: [DataForEntrantInitialization] =
        [
            [
                "type"             : "GuestClassic",            // 1
                "firstName"        : "John",
                "lastName"         : "Doe",
                "streetAddress"    : "Bellemare Street 12",
                "city"             : "Montreal",
                "state"            : "QU",
                "zipCode"          : "400005",
                "dateOfBirth"      : "26-11-1970"
            ],
            [
                "type"             : "GuestClassic",            // 2
            ],
            [
                "type"             : "GuestChild",              // 3
                "firstName"        : "John",
                "lastName"         : "Doe",
                "streetAddress"    : "Bellemare Street 12",
                "city"             : "Montreal",
                "state"            : "QU",
                "zipCode"          : "400005",
                "dateOfBirth"      : "26-11-1970"
            ],
            [
                "type"             : "GuestChild",              // 4 - Should get error noDayOfBirth
                "firstName"        : "John",
                "lastName"         : "Doe",
                "streetAddress"    : "Bellemare Street 12",
                "city"             : "Montreal",
                "state"            : "QU",
                "zipCode"          : "400005"
            ],
            [
                "type"             : "GuestVip",                // 5
                "firstName"        : "John",
                "lastName"         : "Doe",
                "streetAddress"    : "Bellemare Street 12",
                "city"             : "Montreal",
                "state"            : "QU",
                "zipCode"          : "400005",
                "dateOfBirth"      : "26-11-1970"
            ],
            [
                "type"             : "EmployeeFood",            // 6
                "firstName"        : "John",
                "lastName"         : "Doe",
                "streetAddress"    : "Bellemare Street 12",
                "city"             : "Montreal",
                "state"            : "QU",
                "zipCode"          : "400005",
                "dateOfBirth"      : "26-11-1970"
            ],
            [
                "type"             : "EmployeeFood",            // 7 - noFirstName
                "lastName"         : "Doe",
                "streetAddress"    : "Bellemare Street 12",
                "city"             : "Montreal",
                "state"            : "QU",
                "zipCode"          : "400005",
                "dateOfBirth"      : "26-11-1970"
            ],
            [
                "type"             : "EmployeeFood",            // 8 - noCity
                "firstName"        : "John",
                "lastName"         : "Doe",
                "streetAddress"    : "Bellemare Street 12",
                "state"            : "QU",
                "zipCode"          : "400005",
                "dateOfBirth"      : "26-11-1970"
            ],
            [
                "type"             : "EmployeeMaintenance",     // 9
                "firstName"        : "John",
                "lastName"         : "Doe",
                "streetAddress"    : "Bellemare Street 12",
                "city"             : "Montreal",
                "state"            : "QU",
                "zipCode"          : "400005",
                "dateOfBirth"      : "26-11-1970"
            ],
            [
                "type"             : "EmployeeMaintenance",     // 10
                "firstName"        : "John",
                "lastName"         : "Doe",
                "streetAddress"    : "Bellemare Street 12",
                "city"             : "Montreal",
                "state"            : "QU",
                "zipCode"          : "400005",
            ],
            [
                "type"             : "EmployeeMaintenance",     // 11 - noZipCode
                "firstName"        : "John",
                "lastName"         : "Doe",
                "streetAddress"    : "Bellemare Street 12",
                "city"             : "Montreal",
                "state"            : "QU",
                "dateOfBirth"      : "26-11-1970"
            ],
            [
                "type"             : "Manager",                 // 12
                "firstName"        : "John",
                "lastName"         : "Doe",
                "streetAddress"    : "Bellemare Street 12",
                "city"             : "Montreal",
                "state"            : "QU",
                "zipCode"          : "400005",
                "dateOfBirth"      : "26-11-1970"
            ],
            [
                "type"             : "Manager",                 // 13 - noStreetAddress
                "firstName"        : "John",
                "lastName"         : "Doe",
                "city"             : "Montreal",
                "state"            : "QU",
                "zipCode"          : "400005",
            ],
            [
                "type"             : "Manager",                 // 14 - noLastName
                "firstName"        : "John",
                "streetAddress"    : "Bellemare Street 12",
                "city"             : "Montreal",
                "state"            : "QU",
                "zipCode"          : "400005",
                "dateOfBirth"      : "26-11-1970"
            ]
    ]
    
    func initializeFromInput() -> [Entrant] {
        var result: [Entrant] = []
        
        for dict in self.input {
            let keys = dict.keys
            var type: EntrantType? = nil
            var firstName: String?
            var lastName: String?
            var streetAddress: String?
            var city: String?
            var state: String?
            var zipCode: String?
            var dateOfBirth: Date?
            
            for key in keys {
                let value = dict[key]! as String
                switch key {
                    case "type":
                        switch value {
                            case "GuestClassic": type = .GuestClassic
                            case "GuestChild": type = .GuestChild
                            case "GuestVip": type = .GuestVip
                            case "EmployeeFood": type = .EmployeeFood
                            case "EmployeeRide": type = .EmployeeRide
                            case "EmployeeMaintenance": type = .EmployeeMaintenance
                            case "Manager": type = .Manager
                        default:
                            break
                    }
                    case "firstName":
                        firstName = value
                    case "lastName":
                        lastName = value
                    case "streetAddress":
                        streetAddress = value
                    case "city":
                        city = value
                    case "state":
                        state = value
                    case "zipCode":
                        zipCode = value
                    case "dateOfBirth":
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-MM-yyyy"
                        dateOfBirth = dateFormatter.date(from: value)
                default:
                    print("Unknown key!")
                }
            }
            do {
                guard let type = type else {
                    fatalError("Type is nil!")
                }
                let entrant = try Entrant(type: type, firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, dateOfBirth: dateOfBirth)
                result.append(entrant)
            } catch let error {
                if error is EntrantError {
                    let error = error as! EntrantError
                    print("Required \(error.rawValue) did not provided. Please enter \(error.rawValue).")
                } else {
                    fatalError("\(error)")
                }
            }
        }
        return result
    }
}
