//
//  CommonError.swift
//  Chase
//
//  Created by Shingade on 4/19/18.
//  Copyright © 2018 com.abc. All rights reserved.
//

import UIKit


enum DataError : Error {
    case dataReadingError
}

enum JSONError : Error {
    case jsonError
}

enum ParseError : Error {
    case parsingError
}

enum CommonError {
    case success([Any])
    case failure(Error?)
}
