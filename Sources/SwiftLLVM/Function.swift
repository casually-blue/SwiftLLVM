//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation

public struct Function: LLVMTranslationUnit {
    public let name: String
    
    public let resultType: TypeWithAttributes
    public let paramTypes: [TypeWithAttributes]
    
    public let linkage: Linkage?
    public let preemptionSpecifier: RuntimePreemptionSpecifier?
    public let visibility: VisibilityStyle?
    public let dllStorageClass: DLLStorageClass?
    
    public let cconv: CallingConvention?

    
    public let addrType: AddrType?
    public let addrSpace: Int?
    public let section: String?
    public let align: Int?
    
    public let gc: Bool
    
    public var llvm: String {
        return """
        define \(linkage.llvm) \(preemptionSpecifier.llvm) \(visibility.llvm) \(dllStorageClass.llvm) \
        \(cconv.llvm) \(resultType.llvm) @\(name) (\(paramTypes.map{$0.llvm}.joined(separator: ", "))) \
        \(addrType.llvm) \
        \(addrSpace != nil ? "addrspace(" + addrSpace!.description + ")" : "") \
        \(section != nil ? "section \"" + section! + "\"" : "") \
        \(align != nil ? "align " + align!.description : "") {
        \(basicBlocks.map{$0.llvm}.joined(separator: "\n"))
        }
        """.condenseWhiteSpace
    }
    
    public var basicBlocks: [BasicBlock] = []
    
    public mutating func add(block: BasicBlock) {
        basicBlocks.append(block)
    }
    
    public init(
        name: String,
        resultType: TypeWithAttributes,
        paramTypes: [TypeWithAttributes],
        
        linkage: Linkage? = nil,
        preemptionSpecifier: RuntimePreemptionSpecifier? = nil,
        visibility: VisibilityStyle? = nil,
        dllStorageClass: DLLStorageClass? = nil,
        
        cconv: CallingConvention? = nil,
        
        addrType: AddrType? = nil,
        addrSpace: Int? = nil,
        section: String? = nil,
        align: Int? = nil,
        
        gc: Bool = false
    ) {
        self.name = name
        self.resultType = resultType
        self.paramTypes = paramTypes
        self.linkage = linkage
        self.preemptionSpecifier = preemptionSpecifier
        self.visibility = visibility
        self.dllStorageClass = dllStorageClass
        self.cconv = cconv
        self.addrType = addrType
        self.addrSpace = addrSpace
        self.section = section
        self.align = align
        
        self.gc = gc
    }
}
