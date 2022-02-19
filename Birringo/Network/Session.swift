//
//  Session.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 13/2/22.
//

import Foundation
import UIKit
import CoreLocation

final class Session{
    
    static let shared = Session()
    private init(){}
    
    var username : String?
    var api_token : String?
    var password :String?
    
}
