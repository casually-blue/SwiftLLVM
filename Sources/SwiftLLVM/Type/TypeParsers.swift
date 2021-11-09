//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation

enum TypeError: Error {
    case TypesDidNotMatch(initializer: String, type: Type)
}

extension Type {
    public func checkInitializer(typeInitializer: String) -> Bool {
        switch (typeInitializer, self) {
        case ("true", .Integer(1)),
            ("false", .Integer(1)),
            ("null", .Pointer(_)),
            ("none", .Token):
            return true
        case (let val, .Integer(_)):
            return Int(val) != nil ? true : false
        case (let val, .Floating(_)):
            return Float(val) != nil ? true : false
        case (_, .Structure(_, packed: _)):
            return true
        case(_, .Function(_, _)):
            return true
        default:
            return false
        }
    }
}
