//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation


/// A llvm module containing functions and variables
public struct Module: LLVMRepresentable {
    let name: String
    
    /// Get the llvm Assembly Representation of the module
    public var llvm: String {
        return elements.map({return $0.llvm}).joined(separator: "\n\n")
    }
    
    public var elements: [LLVMTranslationUnit] = []
    
    public mutating func add(_ element: LLVMTranslationUnit) {
        self.elements.append(element)
    }
    
    public init(name: String?) {
        self.name = name ?? "___default___"
    }
}
