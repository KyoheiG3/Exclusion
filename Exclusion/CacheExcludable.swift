//
//  CacheExcludable.swift
//  Exclusion
//
//  Created by Kyohei Ito on 2017/12/15.
//  Copyright © 2017年 Kyohei Ito. All rights reserved.
//

protocol CacheExcludable {
    /// it can check response header. return false if needs to refuse to cache.
    func canRespondCache(with httpResponse: HTTPURLResponse) -> Bool
    func canStoreCache(with httpResponse: HTTPURLResponse) -> Bool
}
