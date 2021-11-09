//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation


/// A llvm module containing functions and variables
public struct Module: LLVMRepresentable {
    
    /// Get the llvm Assembly Representation of the module
    public var llvm: String {
        return elements.map({return $0.llvm}).joined(separator: "\n\n")
    }
    
    public let elements: [LLVMTranslationUnit]
}
