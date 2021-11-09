//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation

public indirect enum Type: LLVMRepresentable {
    public var llvm: String {
        switch self {
        case .Void:
            return "void"
        case .Function(let returnType, let parameters):
            return "\(returnType.llvm) (\(parameters.map {$0.llvm}.joined(separator: ", ")))"
        case .Integer(let value):
            return "i\(value)"
        case .Pointer(nil):
            return "ptr"
        case .Pointer(.Function(let type, let params)):
            return Type.Function(type, params).llvm + " *"
        case .Pointer(.some(let t)):
            return t.llvm + "*"
        case .Floating(let f):
            return f.llvm
        case .Label:
            return "label"
        case .Token:
            return "token"
        case .Metadata:
            return "metadata"
        case .Array(size: let size, let t):
            return "[\(size) x \(t.llvm)]"
        case .Structure(let contents, let packed):
            return "\(packed ? "<" : ""){ \(contents.map{$0.llvm}.joined(separator: ", ")) }\(packed ? ">" : "")"
        case .Opaque:
            return "opaque" 
        }
    }
    
    case Void
    
    case Function(Type, [Type])
    
    case Pointer(Type?)
    
    case Integer(UInt)
    
    case Floating(FloatType)
    
    case Label, Token, Metadata
    
    case Array(size: UInt, Type)
    
    case Opaque
    
case Structure([Type], packed: Bool = false)
}

public enum FloatType: LLVMRepresentable {
    public var llvm: String {
        switch self {
        case .Half:
            return "half"
        case .BFloat:
            return "bfloat"
        case .Float:
            return "float"
        case .Double:
            return "double"
        case .Float128:
            return "fp128"
        }
    }
    
    case Half
    case BFloat
    case Float
    case Double
    case Float128
}
