//
//  PostError.swift
//  Continuum
//
//  Created by Jenny Morales on 5/11/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//
import UIKit

enum PostError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    case ckError(Error)
    case couldNotUnwrap
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach the server"
        case .thrownError(let error):
            print(error.localizedDescription)
            return "That Post does not exist\nPlease check your spelling"
        case .noData:
            return "The server responded with no data"
        case .unableToDecode:
            return "The server responded with bad data. Blame the back end team, not the front end"
            
        case .ckError(let error):
            print(error.localizedDescription)
            return "That hype does not exist\nPlease check your spelling"
        case .couldNotUnwrap:
            return "Hype could not be unwrapped, which is not HYPE"
        }
    }
}//End of enum
