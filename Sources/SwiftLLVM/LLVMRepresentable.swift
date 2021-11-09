//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation


/// A llvm object that can be represented as assembly
public protocol LLVMRepresentable {

    
    /// Get the llvm ir representation of the object
    var llvm: String { get }
}

extension Optional: LLVMRepresentable where Wrapped: LLVMRepresentable {
    public var llvm: String {
        return self?.llvm ?? ""
    }
}
