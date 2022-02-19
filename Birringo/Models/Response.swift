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
    var beers : [Beer]?
    var datos_perfil : UserData?
}

struct UserData : Codable {
    var id : Int?
    var name : String?
    var email : String?
    var imagen : String?
    var telefono : Int?
    var puntos : Int?
}

struct Beer : Codable {
    var id : Int?
    var titulo : String?
    var graduacion : String?
    var tipo : String?
    var imagen : String?
    var imagen2 : String?
    var descripcion : String?
    var pubs : [Pubs]?
}

struct Pubs : Codable {
    var id : Int?
    var titulo : String?
    var calle : String?
    var latitud : Double?
    var longitud : Double?
    var distance : Double?
}




