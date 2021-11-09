//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation

public struct BasicBlock: LLVMRepresentable {
    public var llvm: String {
        return ""
    }
    
    let label: String
    let instrs: [Instruction]
}
