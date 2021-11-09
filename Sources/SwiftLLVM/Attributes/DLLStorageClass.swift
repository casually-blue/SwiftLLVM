//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation

/// All ``Global`` variables, ``Function``(s) and ``Alias``(s) can have a ``DLLStorageClass``
public enum DLLStorageClass: LLVMRepresentable {
    public var llvm: String {
        switch self {
        case .DLLExport: return "dllexport"
        case .DLLImport: return "dllimport"
        }
    }
    
    
    
    /// ``DLLImport`` causes the compiler to reference a function or variable via a global pointer to a pointer that is set up by the DLL exporting the symbol.
    /// On Microsoft Windows targets, the pointer name is formed by combining __imp_ and the function or variable name.
    case DLLImport
    
    /// ``DLLExport`` causes the compiler to provide a global pointer to a pointer in a DLL, so that it can be referenced with the dllimport attribute.
    /// On Microsoft Windows targets, the pointer name is formed by combining __imp_ and the function or variable name.
    /// Since this storage class exists for defining a dll interface, the compiler, assembler and linker know it is externally referenced and must refrain from deleting the symbol.``
    case DLLExport
}
