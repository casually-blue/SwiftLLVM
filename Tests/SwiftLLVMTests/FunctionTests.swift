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
}
