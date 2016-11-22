//
//  Car.swift
//  MMLoginRegister
//
//  Created by Mikael Mukhsikaroyan on 11/21/16.
//  Copyright © 2016 MSquaredmm. All rights reserved.
//

import UIKit

public class Car: CustomStringConvertible {
    
    var name: String
    var miles: Int
    
    public init(name: String, miles: Int) {
        self.name = name
        self.miles = miles
    }
    
    public func addMiles(miles: Int) {
        self.miles += miles
    }
    
    public var description: String {
        return "Car '\(name)' has \(miles) miles."
    }
    
}
