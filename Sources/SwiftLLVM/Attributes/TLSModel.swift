//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation

/// Thread local storage models
///
/// The models correspond to the ELF TLS models;
/// The target may choose a different TLS model if the specified model is not supported, or if a better choice of model can be made.
/// A model can also be specified in an alias, but then it only governs how the alias is accessed.
/// It will not have any effect in the aliasee.
/// For platforms without linker support of ELF TLS model, the -femulated-tls flag can be used to generate GCC compatible emulated TLS code.
public enum TLSModel: LLVMRepresentable {
    public var llvm: String {
        switch self {
        case .LocalDynamic:
            return "localdyamic"
        case .InitialExec:
            return "initialexec"
        case .LocalExec:
            return "localexec"
        }
    }
    
    /// For variables that are only used within the current shared library
    case LocalDynamic
    
    /// For variables in modules that will not be loaded dynamically
    case InitialExec
    
    /// For variables defined in the executable and only used within it
    case LocalExec
}

public struct ThreadLocal: LLVMRepresentable {
    public var llvm: String {
        if let m = model {
            return "thread_local(\(m.llvm))"
        } else {
            return "thread_local"
        }
    }
    
    let model: TLSModel?
    
    public init() {
        model = nil
    }
    
    public init(_ model: TLSModel) {
        self.model = model
    }
}
