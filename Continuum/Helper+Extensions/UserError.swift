//
//  UserError.swift
//  Continuum
//
//  Created by Jenny Morales on 5/12/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import Foundation

enum UserError: Error {
    
    case ckError(Error)
    case couldNotUnwrap
    case unexpectedRecordsFound
    case noUserLoggedIn
    
    var errorDescription: String {
        
        switch self {
        case .ckError(let error):
            return error.localizedDescription
            
        case .couldNotUnwrap:
            return "could not unwrap"
            
        case .unexpectedRecordsFound:
            return "unexpected records found"
            
        case .noUserLoggedIn:
            return "no user logged in"
        }
    }
    
}//End of enum
