//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation
import XCTest

@testable import SwiftLLVM

final class ModuleTests: XCTestCase {
    func testBasicModule() throws {
        var m = Module(name: "main")
        m.add(try Global(name: "a", type: .Integer(32), initializer: "4"))
        m.add(try Global(name: "b", type: .Integer(64), initializer: "12"))
        
        XCTAssertEqual(
            m.llvm,
            """
            @a = global i32 4
            
            @b = global i64 12
            """
        )
    }
}
