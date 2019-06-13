//
//  Result.swift
//  TEST
//
//  Created by Stratagile on 07/06/19.
//  Copyright © 2019 ramsheer. All rights reserved.
//

import Foundation
struct ResultObject: Decodable {
    
    var IsSuccess: Bool?
    var Message: Messageob?
}
struct Messageob: Decodable{
    var ErrorCode: Int?
    var Text: [String]?
}
