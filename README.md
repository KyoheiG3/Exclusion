# Exclusion

[![Build Status](https://travis-ci.org/KyoheiG3/Exclusion.svg?branch=master)](https://travis-ci.org/KyoheiG3/Exclusion)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/Exclusion.svg?style=flat)](http://cocoadocs.org/docsets/Exclusion)
[![License](https://img.shields.io/cocoapods/l/Exclusion.svg?style=flat)](http://cocoadocs.org/docsets/Exclusion)
[![Platform](https://img.shields.io/cocoapods/p/Exclusion.svg?style=flat)](http://cocoadocs.org/docsets/Exclusion)

Customizable URLCache.
It can control to store the cache and to respond to the cache. So, using this with `.returnCacheDataElseLoad` of `NSURLRequest.CachePolicy` makes it ideal for caching image resources etc.

## Requirements

- Swift 4.0
- iOS 8.0 or later
- tvOS 9.0 or later

## How to Install Exclusion

#### CocoaPods

Add the following to your `Podfile`:

```Ruby
pod "Exclusion"
```

#### Carthage

Add the following to your `Cartfile`:

```Ruby
github "KyoheiG3/Exclusion"
```

## Usage

### Example

Set it to `URLSessionConfiguration`. also, set `.returnCacheDataElseLoad` to `requestCachePolicy` of configuration if needed.

```swift
let conf = URLSessionConfiguration.default
conf.urlCache = Cache(memoryCapacity: 100 * 1024 * 1024, diskCapacity: 300 * 1024 * 1024, diskPath: "YOUR DIRECTORY PATH")
conf.requestCachePolicy = .returnCacheDataElseLoad
```

If also needs to control to store the cache and to respond to the cache, make an object to set up exclude. For example, you want to control more precisely with the value of Response Header.

```swift
struct Excluder: CacheExcludable {
    func canRespondCache(with httpResponse: HTTPURLResponse) -> Bool {
        return httpResponse.header.cacheControl?.noCache != false
    }

    func canStoreCache(with httpResponse: HTTPURLResponse) -> Bool {
        return httpResponse.header.cacheControl?.noStore != false
    }
}

let cache = Cache(memoryCapacity: 100 * 1024 * 1024, diskCapacity: 300 * 1024 * 1024, diskPath: "YOUR DIRECTORY PATH", excludable: Excluder())
```

### Variable

```swift
var minimumAge: Int
```

- set greater than 0 if needs to return cache forcibly, then the cache will be returned until past it.
- if it is set less than 0, it is ignored.
- also, it checks before the validity of response header.

### Function

```swift
init(memoryCapacity: Int, diskCapacity: Int, diskPath path: String?, excludable: CacheExcludable? = default)
```

- can set excludable object.

## Author

#### Kyohei Ito

- [GitHub](https://github.com/kyoheig3)
- [Twitter](https://twitter.com/kyoheig3)

Follow me 🎉

## LICENSE

Under the MIT license. See LICENSE file for details.
