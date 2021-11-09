//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation

/// A LLVM global variable or constant
public struct Global: LLVMTranslationUnit {
    public var llvm: String {
        return """
        @\(name) = \(linkage.llvm) \(preemptionSpecifier.llvm) \(visibility.llvm) \
        \(dllStorageClass.llvm) \(threadLocal.llvm) \
        \(localUnnamed.llvm) \(addrSpace != nil ? "addrspace(" + addrSpace!.description + ")" : "") \
        \(externallyInitialized ? "externally_initialied" : "") \
        \(constant ? "constant" : "global") \(type.llvm) \(initializer ?? "")\
        \(section != nil ? ", section \"" + section! + "\"" : "")\(align != nil ? ", align " + align!.description : "")
        """.condenseWhiteSpace
    }
    
    public let name: String
    
    public let linkage: Linkage?
    public let preemptionSpecifier: RuntimePreemptionSpecifier?
    public let visibility: VisibilityStyle?
    
    public let dllStorageClass: DLLStorageClass?
    public let threadLocal: ThreadLocal?
    
    public let localUnnamed: AddrType?
    public let addrSpace: Int?

    public let constant: Bool
    public let type: Type

    public let externallyInitialized: Bool
    
    public let initializer: String?
    
    public let section: String?
    
    public let align: Int?
    
    public init(name: String,
                linkage: Linkage? = nil,
                preemptionSpecifier: RuntimePreemptionSpecifier? = nil,
                visibility: VisibilityStyle? = nil,
                dllStorageClass: DLLStorageClass? = nil,
                threadLocal: ThreadLocal? = nil,
                localUnnamed: AddrType? = nil,
                addrSpace: Int? = nil,
                constant: Bool = false,
                type: Type,
                externallyInitialized: Bool = false,
                initializer: String? = nil,
                section: String? = nil,
                align: Int? = nil
    ) throws {
        self.name = name
        self.linkage = linkage
        self.preemptionSpecifier = preemptionSpecifier
        self.visibility = visibility
        self.dllStorageClass = dllStorageClass
        self.threadLocal = threadLocal
        self.localUnnamed = localUnnamed
        self.addrSpace = addrSpace
        self.constant = constant
        self.type = type
        self.externallyInitialized = externallyInitialized
        self.initializer = initializer
        self.section = section
        self.align = align
        
        if let i = self.initializer {
            if !self.type.checkInitializer(typeInitializer: i) {
                throw TypeError.TypesDidNotMatch(initializer: i, type: type)
            }
        }
    }
}
