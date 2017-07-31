//
//  ExampleProtocol.swift
//  YYProjectNew
//
//  Created by yangyh on 2017/7/31.
//  Copyright © 2017年 yangyh. All rights reserved.
//

import Foundation

protocol ExampleProtocol {
    
    var simple: String {get}
    mutating func adjust()
}

extension Int: ExampleProtocol {
    
    var simple: String {
        
        return "dsaf \(self)"
    }
    
    mutating func adjust() {
        
        self += 43
    }
}
