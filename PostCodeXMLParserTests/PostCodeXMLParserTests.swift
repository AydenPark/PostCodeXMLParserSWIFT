//
//  PostCodeXMLParserTests.swift
//  PostCodeXMLParserTests
//
//  Created by jigwan on 2015. 11. 14..
//  Copyright © 2015년 Ayden. All rights reserved.
//

import XCTest
@testable import PostCodeXMLParser

class PostCodeXMLParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let strDong: NSString = "덕계동"
        let strRegKey: NSString = "API Reg Key"
        
        let postcode = PostCodeXMLParser()
        
        let arrResult = postcode.getPostCode(strDong, strReg: strRegKey)
        
        for n in 0...arrResult.count-1 {
            let strPostcode: NSString = arrResult.objectAtIndex(n).objectForKey("postcode") as! NSString
            let strAddr: NSString = arrResult.objectAtIndex(n).objectForKey("address") as! NSString
            NSLog("%@ - %@", strPostcode, strAddr)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
