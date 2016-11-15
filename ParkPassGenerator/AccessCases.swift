//
//  RideTurnstile.swift
//  ParkPassGenerator
//
//  Created by Alexey Papin on 15.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

protocol Checking {
    func check(for entrant: Entrant)
}

struct RideTurnstyle: Checking {
    func check(for entrant: Entrant) {
        if entrant.access.contains(Access.AllRides) {
                print("Access to \(self) for \(entrant) is granted!")
            } else {
                print("Access to \(self) for \(entrant) denied!")
            }
    }
}

struct Kitchen: Checking {
    func check(for entrant: Entrant) {
        if entrant.areas.contains(Area.Kitchen) {
            print("Access to \(self) for \(entrant) is granted!")
        } else {
            print("Access to \(self) for \(entrant) denied!")
        }
    }
}

struct CashRegister: Checking {
    func check(for entrant: Entrant) {
        print("\(entrant) has \(entrant.discount.food)% discount for food and \(entrant.discount.merchant)% for merchandise")
    }
}




















