//
//  CacheControlTests.swift
//  ExclusionTests
//
//  Created by Kyohei Ito on 2017/12/15.
//  Copyright © 2017年 Kyohei Ito. All rights reserved.
//

import XCTest
@testable import Exclusion

class CacheControlTests: XCTestCase {
    let cacheControlString = "must-revalidate, no-cache, no-store, no-transform, public, private, proxy-revalidate, max-age=100, s-maxage=100"

    func testCacheControl() {
        let cacheControl = HTTPURLResponse.CacheControl(string: cacheControlString)
        XCTAssertTrue(cacheControl.mustRevalidate)
        XCTAssertTrue(cacheControl.noCache)
        XCTAssertTrue(cacheControl.noStore)
        XCTAssertTrue(cacheControl.noTransform)
        XCTAssertTrue(cacheControl.private)
        XCTAssertTrue(cacheControl.proxyRevalidate)
        XCTAssertTrue(cacheControl.public)
        XCTAssertEqual(cacheControl.maxAge, 100)
        XCTAssertEqual(cacheControl.sMaxAge, 100)
    }
}
