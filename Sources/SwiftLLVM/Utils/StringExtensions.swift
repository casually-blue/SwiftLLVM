//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation

extension String {
    public var condenseWhiteSpace: Self {
        return self.components(separatedBy: .whitespaces).filter {!$0.isEmpty}.joined(separator: " ").trimmingCharacters(in: .whitespaces)
    }
}
