//
//  CacheTests.swift
//  ExclusionTests
//
//  Created by Kyohei Ito on 2017/12/15.
//  Copyright © 2017年 Kyohei Ito. All rights reserved.
//

import XCTest
@testable import Exclusion

class CacheTests: XCTestCase {
    let url = URL(string: "http://example.com/spec")!
    var request: URLRequest!
    var cache: Cache!

    override func setUp() {
        cache = Cache(memoryCapacity: 1024*1024*10, diskCapacity: 1024*1024*10, diskPath: "CacheTests")
        request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
    }

    func testNilTarget() {
        XCTAssertFalse(cache.dateIsPast(nil))
    }

    func testNotHTTPResponse() {
        let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let cachedResponse = CachedURLResponse(response: response, data: Data())

        cache.storeCachedResponse(cachedResponse, for: request)
        XCTAssertNil(cache.cachedResponse(for: request))
    }

    func testExpiredCache() {
        let dateString = "Wed, 06 Dec 2007 09:38:38 GMT"
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: ["Expires": dateString])
        let cachedResponse = CachedURLResponse(response: response!, data: Data())

        cache.storeCachedResponse(cachedResponse, for: request)
        XCTAssertNil(cache.cachedResponse(for: request))

        cache.minimumAge = 1000

        cache.storeCachedResponse(cachedResponse, for: request)
        XCTAssertNil(cache.cachedResponse(for: request))

        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "E, dd M yyyy HH:mm:ss Z"
        if let date = df.date(from: dateString) {
            cache.minimumAge = Int(Date().timeIntervalSince(date)) + 1000
        }

        cache.storeCachedResponse(cachedResponse, for: request)
        XCTAssertNotNil(cache.cachedResponse(for: request))

        cache.minimumAge = 0
        XCTAssertNil(cache.cachedResponse(for: request))
    }

    func testNotExpiredCache() {
        let dateString = "Wed, 06 Dec 2037 09:38:38 GMT"
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: ["Expires": dateString])
        let cachedResponse = CachedURLResponse(response: response!, data: Data())

        cache.storeCachedResponse(cachedResponse, for: request)
        XCTAssertNotNil(cache.cachedResponse(for: request))
    }
}
