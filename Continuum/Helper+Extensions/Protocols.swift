//
//  SearchableRecord.swift
//  Continuum
//
//  Created by Jenny Morales on 5/12/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

//MARK: - Protocol
protocol SearchableRecord: Any {
    func matches(searchTerm: String) -> Bool
}//End of protocol

protocol PhotoSelectorViewControllerDelegate: class {
    func photoSelectorViewControllerSelected(image: UIImage)
}//End of protocol
