//
//  Response.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 13/2/22.
//

import Foundation

struct Response: Codable {
    var status : Int
    var msg : String
    var api_token : String?
    var listado_empleados : [UserData]?
    var datos_perfil : UserData?
    //Como esruturar datos?
}
struct UserData : Codable {
    var id : Int
    var name : String
    var email : String?
    var password : String?
    var telefono : String?
}
