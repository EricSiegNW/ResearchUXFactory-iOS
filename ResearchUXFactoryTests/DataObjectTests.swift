//
//  SBADataObjectTests.swift
//  ResearchUXFactory
//
//  Copyright © 2016 Sage Bionetworks. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// 1.  Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2.  Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation and/or
// other materials provided with the distribution.
//
// 3.  Neither the name of the copyright holder(s) nor the names of any contributors
// may be used to endorse or promote products derived from this software without
// specific prior written permission. No license is granted to the trademarks of
// the copyright holders even if such marks are included in this software.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

import XCTest
import ResearchKit
import ResearchUXFactory

class SBADataObjectTests: ResourceTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testClassTypeMap_AutomaticallyMappedBridgeAppObject() {
        
        let result: AnyClass? = SBAClassTypeMap.shared.class(forClassType: "SBAMedication")
        XCTAssertNotNil(result)
        guard let classType = result as? SBATrackedDataObject.Type else {
            XCTAssert(false, "\(String(describing: result)) not of expected class type")
            return
        }
        
        let obj = classType.init(identifier: "abc123")
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj.identifier, "abc123")
        
        guard let _ = obj as? SBAMedication else {
            XCTAssert(false, "\(obj) not of expected class type")
            return
        }
    }
    
    func testClassTypeMap_AutomaticallyMappedBundleObject() {
        let result: AnyClass? = SBAClassTypeMap.shared.class(forClassType: "MockORKTaskWithoutOptionals")
        XCTAssertNotNil(result)
    }
    
    func testClassTypeMap_PlistMappedBridgeAppObjects() {

        let result: AnyClass? = SBAClassTypeMap.shared.class(forClassType: "Medication")
        XCTAssertNotNil(result)
        guard let _ = result as? SBAMedication.Type else {
            XCTAssert(false, "\(String(describing: result)) not of expected class type")
            return
        }
    }
    
    func testClassTypeMap_SwiftClass() {
        
        let result: AnyClass? = SBAClassTypeMap.shared.class(forClassType: "TrackedDataObjectCollection")
        XCTAssertNotNil(result)
        guard let _ = result as? SBATrackedDataObjectCollection.Type else {
            XCTAssert(false, "\(String(describing: result)) not of expected class type")
            return
        }
    }

}
