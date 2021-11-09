//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation

public enum RuntimePreemptionSpecifier: LLVMRepresentable {
    public var llvm: String {
        switch self {
        case .Preemptable: return "dso_preemptable"
        case .Local: return "dso_local"
        }
    }
    
    /// Indicates that the function or variable may be replaced by a symbol from outside the linkage unit at runtime.
    case Preemptable
    
    /// The compiler may assume that a function or variable marked as  ``Local`` will resolve to a symbol within the same linkage unit.
    /// Direct access will be generated even if the definition is not within this compilation unit.
    case Local
}
