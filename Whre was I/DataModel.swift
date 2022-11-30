//
//  DataModel.swift
//  Where was I
//
//  Created by Samuel Noye on 04/05/2022.
//

import Foundation

class VisitedPoint {
    var latitude: String
    var longitude: String
    
    init(lat: String, long: String) {
        self.latitude = lat
        self.longitude = long
    }
}
