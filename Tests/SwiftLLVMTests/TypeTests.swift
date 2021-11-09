//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation
import XCTest

@testable import SwiftLLVM

final class TypeTests: XCTestCase {
    func testCreateType() throws {
        XCTAssertEqual(
            Type.Integer(32).llvm,
            "i32"
        )
    }
    
    func testCreateFunctionType() throws {
        XCTAssertEqual(
            Type.Function(.Integer(32), [.Integer(8), .Integer(8)]).llvm,
            "i32 (i8, i8)"
        )
    }
    
    func testCreateArrayType() throws {
        XCTAssertEqual(
            Type.Array(size: 4, .Integer(8)).llvm,
            "[4 x i8]"
        )
    }
    
    func testCreateStructureType() throws {
        XCTAssertEqual(
            Type.Structure([.Integer(32), .Integer(32)]).llvm,
            "{ i32, i32 }"
        )
    }
    
    func testCreatePackedStructureType() throws {
        XCTAssertEqual(
            Type.Structure([.Integer(64), .Integer(64)], packed: true).llvm,
            "<{ i64, i64 }>"
        )
    }
    
    func testCreateStructWithFunctionPtr() throws {
        XCTAssertEqual(
            Type.Structure([.Integer(32), .Pointer(.Function(.Integer(32), [.Integer(8)]))]).llvm,
            "{ i32, i32 (i8) * }"
        )
    }
}
