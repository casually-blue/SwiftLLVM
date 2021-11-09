//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation
import XCTest

@testable import SwiftLLVM

final class FunctionTests: XCTestCase {
    func testBasicFunction() throws {
        XCTAssertEqual(
            Function(name: "test",
                     resultType: TypeWithAttributes(.Integer(32)),
                     paramTypes: [
                        TypeWithAttributes(.Integer(32)), TypeWithAttributes(.Integer(32))
                     ]
                    ).llvm,
            """
            define i32 @test (i32, i32) {
            
            }
            """
        )
    }
    
    func testBasicFunctionWithBlocks() throws {
        var f = Function(name: "test",
                         resultType: TypeWithAttributes(.Integer(32)),
                         paramTypes: [])
        f.add(block: BasicBlock(label: "entry", instrs: []))
        
        XCTAssertEqual(
            f.llvm,
        """
        define i32 @test () {
        entry:
        }
        """)
    }
}
