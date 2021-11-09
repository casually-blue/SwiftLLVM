//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation

public enum AddrType: LLVMRepresentable {
    public var llvm: String {
        switch self {
        case .Unnamed:
            return "unnamed_addr"
        case .LocalUnnamed:
            return "local_unnamed_addr"
        }
    }
    
    case Unnamed, LocalUnnamed
}
