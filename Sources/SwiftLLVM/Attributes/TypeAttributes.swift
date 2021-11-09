//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation

public enum TypeAttribute: LLVMRepresentable {
    public var llvm: String {
        switch self {
        case .ZeroExt:
            return "zeroext"
        case .SignExt:
            return "signext"
        case .InReg:
            return "inreg"
        case .ByValue(let type):
            return "byval(\(type.llvm))"
        case .ByRef(let type):
            return "byref(\(type.llvm))"
        case .PreAllocated(let type):
            return "preallocated(\(type.llvm))"
        case .InAlloca(let type):
            return "inalloca(\(type.llvm))"
        case .SRet(let type):
            return "sret(\(type.llvm))"
        case .ElementType(let type):
            return "elementtype(\(type.llvm))"
        case .Align(let int):
            return "align \(int)"
        case .NoAlias:
            return "noalias"
        case .NoCapture:
            return "nocapture"
        case .NoFree:
            return "nofree"
        case .Nest:
            return "nest"
        case .Returned:
            return "returned"
        case .NonNull:
            return "nonnull"
        case .Dereferenceable(let int):
            return "dereferenceable(\(int))"
        case .DereferenceableOrNull(let int):
            return "dereferenceable_or_null(\(int))"
        case .SwiftSelf:
            return "swiftself"
        case .SwiftAsync:
            return "swiftasync"
        case .SwiftError:
            return "swifterror"
        case .ImmArg:
            return "immarg"
        case .NoUndef:
            return "noundef"
        case .AlignStack(let int):
            return "alignstack(\(int))"
        }
    }
    
    case ZeroExt
    case SignExt
    
    case InReg
    case ByValue(Type)
    case ByRef(Type)
    case PreAllocated(Type)
    case InAlloca(Type)
    case SRet(Type)
    case ElementType(Type)
    case Align(Int)
    case NoAlias
    case NoCapture
    case NoFree
    case Nest
    case Returned
    case NonNull
    case Dereferenceable(Int)
    case DereferenceableOrNull(Int)
    case SwiftSelf
    case SwiftAsync
    case SwiftError
    case ImmArg
    case NoUndef
    case AlignStack(Int)
}

public struct TypeWithAttributes: LLVMRepresentable {
    public var llvm: String {
        return "\(attributes.map{$0.llvm}.joined(separator: " ")) \(type.llvm)".trimmingCharacters(in: .whitespaces)
    }
    
    public let attributes: [TypeAttribute]
    public let type: Type
    
    public init(_ type: Type, _ attributes: [TypeAttribute] = []) {
        self.attributes = attributes
        self.type = type
    }
}
