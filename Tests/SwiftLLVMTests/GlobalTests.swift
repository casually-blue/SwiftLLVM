//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation
import XCTest

@testable import SwiftLLVM

final class GlobalTests: XCTestCase {
    func testBasicGlobal() throws {
        XCTAssertEqual(
            try Global(name: "a", type: .Integer(32), initializer: "5").llvm,
            "@a = global i32 5")
    }
    
    func testLLVMDocsConstantFloat() throws {
        XCTAssertEqual(
            try Global(name: "G", addrSpace: 5, constant: true, type: .Floating(.Float), initializer: "1.0", section: "foo", align: 4).llvm,
            "@G = addrspace(5) constant float 1.0, section \"foo\", align 4"
        )
    }
    
    func testLLVMDocsGlobalInt() throws {
        XCTAssertEqual(
            try Global(name: "G", linkage: .External, type: .Integer(32)).llvm,
            "@G = external global i32"
        )
    }
    
    func testLLVMDocsThreadLocal() throws {
        XCTAssertEqual(
            try Global(name: "G", threadLocal: ThreadLocal(.InitialExec), type: .Integer(32), initializer: "0", align: 4).llvm,
            "@G = thread_local(initialexec) global i32 0, align 4"
        )
    }
}
