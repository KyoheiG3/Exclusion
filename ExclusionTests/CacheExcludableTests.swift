//
//  CacheExcludableTests.swift
//  ExclusionTests
//
//  Created by Kyohei Ito on 2017/12/15.
//  Copyright © 2017年 Kyohei Ito. All rights reserved.
//

import XCTest
@testable import Exclusion

final class MockCacheExcludable: CacheExcludable {
    var canRespondCache = false
    var canStoreCache = false

    func canRespondCache(with httpResponse: HTTPURLResponse) -> Bool {
        return canRespondCache
    }

    func canStoreCache(with httpResponse: HTTPURLResponse) -> Bool {
        return canStoreCache
    }
}

class CacheExcludableTests: XCTestCase {
    func testExcludable() {
        let url = URL(string: "http://example.com/spec")!
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad

        let excludable = MockCacheExcludable()
        let cache = Cache(memoryCapacity: 1024*1024*10, diskCapacity: 1024*1024*10, diskPath: "CacheExcludableTests", excludable: excludable)
        let dateString = "Wed, 06 Dec 2037 09:38:38 GMT"
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: ["Expires": dateString])
        let cachedResponse = CachedURLResponse(response: response!, data: Data())

        excludable.canRespondCache = true
        cache.storeCachedResponse(cachedResponse, for: request)
        XCTAssertNil(cache.cachedResponse(for: request))

        excludable.canStoreCache = true
        excludable.canRespondCache = false
        cache.storeCachedResponse(cachedResponse, for: request)
        XCTAssertNil(cache.cachedResponse(for: request))

        excludable.canRespondCache = true
        cache.storeCachedResponse(cachedResponse, for: request)
        XCTAssertNotNil(cache.cachedResponse(for: request))
    }
}
