//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation

public enum VisibilityStyle: LLVMRepresentable, Hashable, Equatable {
    public var llvm: String {
        switch self {
        case .Default:
            return "default"
        case .Hidden:
            return "hidden"
        case .Protected:
            return "protected"
        }
    }
    
    /// Default Style
    ///
    /// On targets that use the ELF object file format, default visibility means that the declaration is visible to other modules and, in shared libraries, means that the declared entity may be overridden.
    /// On Darwin, default visibility means that the declaration is visible to other modules.
    /// Default visibility corresponds to “external linkage” in the language.
    case Default
    
    /// Hidden Style
    ///
    /// Two declarations of an object with hidden visibility refer to the same object if they are in the same shared object.
    /// Usually, hidden visibility indicates that the symbol will not be placed into the dynamic symbol table, so no other module (executable or shared library) can reference it directly.
    case Hidden
    
    /// Protected Style
    ///
    /// On ELF, protected visibility indicates that the symbol will be placed in the dynamic symbol table, but that references within the defining module will bind to the local symbol. That is, the symbol cannot be overridden by another module.
    case Protected
}
