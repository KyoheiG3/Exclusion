//
//  HeaderTests.swift
//  ExclusionTests
//
//  Created by Kyohei Ito on 2017/12/15.
//  Copyright © 2017年 Kyohei Ito. All rights reserved.
//

import XCTest
@testable import Exclusion

class HeaderTests: XCTestCase {
    let url = URL(string: "http://example.com/spec")!
    let cacheControlString = "must-revalidate, no-cache, no-store, no-transform, public, private, proxy-revalidate, max-age=100, s-maxage=100"

    func response(_ headerFields: [String: String]?) -> HTTPURLResponse? {
        return HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: headerFields)
    }

    func testHeader() {
        XCTAssertNotNil(response([:])?.header)
        XCTAssertNotNil(response(["Cache-Control": cacheControlString])?.header.cacheControl)
        XCTAssertNotNil(response(["Date": "Wed, 06 Dec 2017 09:38:38 GMT"])?.header.date)
        XCTAssertNotNil(response(["Last-Modified": "Wed, 06 Dec 2017 09:38:38 GMT"])?.header.lastModified)
        XCTAssertNotNil(response(["Expires": "Wed, 06 Dec 2017 09:38:38 GMT"])?.header.expires)
        XCTAssertNil(response(["Cache-Control": cacheControlString])?.header.expires)
        XCTAssertNotNil(response(["Date": "Wed, 06 Dec 2017 09:38:38 GMT"])?.header.expires)
        XCTAssertNotNil(response(["Date": "Wed, 06 Dec 2017 09:38:38 GMT", "Cache-Control": cacheControlString])?.header.expires)
        XCTAssertNotNil(response(["Etag": "HTTPURLResponse Header Etag"])?.header.etag)
        XCTAssertEqual(HTTPURLResponse.Header.FieldKey("A"), HTTPURLResponse.Header.FieldKey("A"))
        XCTAssertNotEqual(HTTPURLResponse.Header.FieldKey("A"), HTTPURLResponse.Header.FieldKey("B"))
    }
}
