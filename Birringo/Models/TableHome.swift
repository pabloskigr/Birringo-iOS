//
//  TableHome.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 25/1/22.
//

import Foundation
import UIKit
import CoreLocation
//PRUEBA DATA LOCAL
struct beerData {
    var titulo: String
    var ml:String
    var image:UIImage
    var description: String
    var location: [Bares]
}

struct Bares {
    var title: String
    var latitud: Double
    var longitud: Double
    var distance : Double?
}

struct PerfilData {
    var title: String
    var image: UIImage
}
struct AjustesData {
    var title: String
}

struct RankingData {
    var image : UIImage
    var username : String
    var userPoints : Int
}

struct QuestData {
    var title : String
    var points : Int
    var location: [Bares]
    //habira que añadir localizacion y descripcion para el detail.
}
struct MockData{
    
    static let ajustes: [AjustesData] = [
        AjustesData(title: "POLITICA DE PRIVACIDAD"),
        AjustesData(title: "TUTORIAL"),
        AjustesData(title: "TERMINOS LEGALES")
    ]
    
    static let datos: [beerData] = [
        beerData(titulo: "Heineken", ml: "750", image: UIImage(named: "beer_image")!, description: "Cerveza de Holanda de renombre conocida por todo el mundial", location: bares1),
        beerData(titulo: "Estrella Galicia", ml: "750", image: UIImage(named: "cerveza-almeria")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares2),
        beerData(titulo: "Leffe", ml: "750", image: UIImage(named: "cerveza-leffe")!, description: "Cerveza de Holanda de renombre conocida por todo el mundial", location: bares3),
        beerData(titulo: "La Virgen", ml: "750", image: UIImage(named: "cerveza-Modelo")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares4),
        beerData(titulo: "El Alguila", ml: "750", image: UIImage(named: "Cervezas-la-Virgen")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares5),
        beerData(titulo: "Corona", ml: "750", image: UIImage(named: "cerveza-Modelo")!, description: "Cerveza de Mexico de renombre conocida por todo el mundial", location: bares6),
        beerData(titulo: "Life", ml: "750", image: UIImage(named: "cerveza-leffe")!, description: "Cerveza de USA de renombre conocida por todo el mundial", location: bares7),
        beerData(titulo: "BUD LiGHT", ml: "750", image: UIImage(named: "cerveza-almeria")!, description: "Cerveza de USA de renombre conocida por todo el mundial", location: bares8)
    ]
    
    static let ale: [beerData] = [
        beerData(titulo: "Heineken", ml: "750", image: UIImage(named: "cerveza-almeria")!, description: "Cerveza de Holanda de renombre conocida por todo el mundial", location: bares1),
        beerData(titulo: "Estrella Galicia", ml: "750", image: UIImage(named: "Cervezas-la-Virgen")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares2),
        beerData(titulo: "Leffe", ml: "750", image: UIImage(named: "cerveza-leffe")!, description: "Cerveza de Holanda de renombre conocida por todo el mundial", location: bares3),
        beerData(titulo: "La Virgen", ml: "750", image: UIImage(named: "cerveza-Modelo")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares4),
        beerData(titulo: "El Alguila", ml: "750", image: UIImage(named: "Cervezas-la-Virgen")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares5),
        beerData(titulo: "Corona", ml: "750", image: UIImage(named: "cerveza-Modelo")!, description: "Cerveza de Mexico de renombre conocida por todo el mundial", location: bares6),
        beerData(titulo: "Life", ml: "750", image: UIImage(named: "cerveza-leffe")!, description: "Cerveza de USA de renombre conocida por todo el mundial", location: bares7),
        beerData(titulo: "BUD LiGHT", ml: "750", image: UIImage(named: "cerveza-Modelo")!, description: "Cerveza de USA de renombre conocida por todo el mundial", location: bares8)
    ]
    
    static let tostada: [beerData] = [
        beerData(titulo: "Heineken", ml: "750", image: UIImage(named: "cerveza-leffe")!, description: "Cerveza de Holanda de renombre conocida por todo el mundial", location: bares1),
        beerData(titulo: "Estrella Galicia", ml: "750", image: UIImage(named: "cerveza-almeria")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares2),
        beerData(titulo: "Leffe", ml: "750", image: UIImage(named: "cerveza-Modelo")!, description: "Cerveza de Holanda de renombre conocida por todo el mundial", location: bares3),
        beerData(titulo: "La Virgen", ml: "750", image: UIImage(named: "Cervezas-la-Virgen")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares4),
        beerData(titulo: "El Alguila", ml: "750", image: UIImage(named: "cerveza-leffe")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares5),
        beerData(titulo: "Corona", ml: "750", image: UIImage(named: "cerveza-Modelo")!, description: "Cerveza de Mexico de renombre conocida por todo el mundial", location: bares6),
        beerData(titulo: "Life", ml: "750", image: UIImage(named: "cerveza-leffe")!, description: "Cerveza de USA de renombre conocida por todo el mundial", location: bares7),
        beerData(titulo: "BUD LiGHT", ml: "750", image: UIImage(named: "cerveza-almeria")!, description: "Cerveza de USA de renombre conocida por todo el mundial", location: bares8)
    ]
    
    static let rubia: [beerData] = [
        beerData(titulo: "Heineken", ml: "750", image: UIImage(named: "beer_image")!, description: "Cerveza de Holanda de renombre conocida por todo el mundial", location: bares1),
        beerData(titulo: "Estrella Galicia", ml: "750", image: UIImage(named: "cerveza-almeria")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares2),
        beerData(titulo: "Leffe", ml: "750", image: UIImage(named: "cerveza-leffe")!, description: "Cerveza de Holanda de renombre conocida por todo el mundial", location: bares3),
        beerData(titulo: "La Virgen", ml: "750", image: UIImage(named: "cerveza-Modelo")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares4),
        beerData(titulo: "El Alguila", ml: "750", image: UIImage(named: "Cervezas-la-Virgen")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares5),
        beerData(titulo: "Corona", ml: "750", image: UIImage(named: "cerveza-Modelo")!, description: "Cerveza de Mexico de renombre conocida por todo el mundial", location: bares6),
        beerData(titulo: "Life", ml: "750", image: UIImage(named: "cerveza-leffe")!, description: "Cerveza de USA de renombre conocida por todo el mundial", location: bares7),
        beerData(titulo: "BUD LiGHT", ml: "750", image: UIImage(named: "cerveza-almeria")!, description: "Cerveza de USA de renombre conocida por todo el mundial", location: bares8)
    ]
    static let negra: [beerData] = [
        beerData(titulo: "Heineken", ml: "750", image: UIImage(named: "cerveza-almeria")!, description: "Cerveza de Holanda de renombre conocida por todo el mundial", location: bares1),
        beerData(titulo: "Estrella Galicia", ml: "750", image: UIImage(named: "Cervezas-la-Virgen")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares2),
        beerData(titulo: "Leffe", ml: "750", image: UIImage(named: "cerveza-leffe")!, description: "Cerveza de Holanda de renombre conocida por todo el mundial", location: bares3),
        beerData(titulo: "La Virgen", ml: "750", image: UIImage(named: "cerveza-Modelo")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares4),
        beerData(titulo: "El Alguila", ml: "750", image: UIImage(named: "Cervezas-la-Virgen")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares5),
        beerData(titulo: "Corona", ml: "750", image: UIImage(named: "cerveza-Modelo")!, description: "Cerveza de Mexico de renombre conocida por todo el mundial", location: bares6),
        beerData(titulo: "Life", ml: "750", image: UIImage(named: "cerveza-leffe")!, description: "Cerveza de USA de renombre conocida por todo el mundial", location: bares7),
        beerData(titulo: "BUD LiGHT", ml: "750", image: UIImage(named: "cerveza-Modelo")!, description: "Cerveza de USA de renombre conocida por todo el mundial", location: bares8)
    ]
    
    
    static let bares1: [Bares] = [
        Bares(title: "La virgen", latitud: 40.44507263083099, longitud: -3.6707148455739422),
        Bares(title: "El Burro", latitud: 40.4468810140345, longitud: -3.6965371429331326),
        Bares(title: "La Laguna", latitud: 40.45033390335384, longitud: -3.6948503436539166)
    ]
    static let bares2: [Bares] = [
        Bares(title: "La virgen", latitud: 40.44507263083099, longitud: -3.6707148455739422),
        Bares(title: "La Leña", latitud: 40.4468810140345, longitud: -3.6965371429331326),
        Bares(title: "La mesa", latitud: 40.45033390335384, longitud: -3.6948503436539166)
    ]
    static let bares3: [Bares] = [
        Bares(title: "El meson", latitud: 40.44507263083099, longitud: -3.6707148455739422),
        Bares(title: "El Rincon de Paco", latitud: 40.4468810140345, longitud: -3.6965371429331326),
        Bares(title: "Bar", latitud: 40.45033390335384, longitud: -3.6948503436539166)
    ]
    static let bares4: [Bares] = [
        Bares(title: "El cienMontaditos", latitud: 40.44507263083099, longitud: -3.6707148455739422),
        Bares(title: "La Sureña", latitud: 40.4468810140345, longitud: -3.6965371429331326),
        Bares(title: "Artico", latitud: 40.45033390335384, longitud: -3.6948503436539166)
    ]
    static let bares5: [Bares] = [
        Bares(title: "Artico", latitud: 40.44507263083099, longitud: -3.6707148455739422),
        Bares(title: "La Maria", latitud: 40.4468810140345, longitud: -3.6965371429331326),
        Bares(title: "La Negra", latitud: 40.45033390335384, longitud: -3.6948503436539166)
    ]
    static let bares6: [Bares] = [
        Bares(title: "La Blanca", latitud: 40.44507263083099, longitud: -3.6707148455739422),
        Bares(title: "La Lenta", latitud: 40.4468810140345, longitud: -3.6965371429331326),
        Bares(title: "La virgen", latitud: 40.45033390335384, longitud: -3.6948503436539166)
    ]
    static let bares7: [Bares] = [
        Bares(title: "El norte", latitud: 40.44507263083099, longitud: -3.6707148455739422),
        Bares(title: "Los Nachos", latitud: 40.4468810140345, longitud: -3.6965371429331326),
        Bares(title: "La virgen", latitud: 40.45033390335384, longitud: -3.6948503436539166)
    ]
    static let bares8: [Bares] = [
        Bares(title: "La Marina", latitud: 40.44507263083099, longitud: -3.6707148455739422),
        Bares(title: "La Juana", latitud: 40.4468810140345, longitud: -3.6965371429331326),
        Bares(title: "La Luna", latitud: 40.45033390335384, longitud: -3.6948503436539166)
    ]
    
    //Quest relacion 1:1
    static let bar1: [Bares] = [
        Bares(title: "Bar Paco", latitud: 40.44507263083099, longitud: -3.6707148455739422)
    ]
    static let bar2: [Bares] = [
        Bares(title: "Bar artemisa", latitud: 40.44507263083099, longitud: -3.6707148455739422)
    ]
    static let bar3: [Bares] = [
        Bares(title: "La virgen", latitud: 40.44507263083099, longitud: -3.6707148455739422)
    ]
    static let bar4: [Bares] = [
        Bares(title: "La Lenta", latitud: 40.44507263083099, longitud: -3.6707148455739422)
    ]
    static let bar5: [Bares] = [
        Bares(title: "Zukumbar", latitud: 40.45033390335384, longitud: -3.6948503436539166)
    ]
    static let bar6: [Bares] = [
        Bares(title: "La luna", latitud: 40.45033390335384, longitud: -3.6948503436539166)
    ]
    //FIN BARES QUEST
    static let datosPerfil: [PerfilData] = [
        PerfilData(title: "Ajustes", image: UIImage(named: "Ajustes")!),
        PerfilData(title: "Favoritos", image: UIImage(named: "Favoritos")!),
        PerfilData(title: "Cerrar sesion", image: UIImage(named: "CerrarSesion")!)
    ]
    
    static let ranking: [RankingData] = [
        RankingData(image: UIImage(named: "user_img")!, username: "Paco gonzalez", userPoints: 6450),
        RankingData(image: UIImage(named: "user_img")!, username: "Juan gonzalez", userPoints: 5500),
        RankingData(image: UIImage(named: "user_img")!, username: "Alberto gonzalez", userPoints: 4350),
        RankingData(image: UIImage(named: "user_img")!, username: "Pablo gonzalez", userPoints: 3200),
        RankingData(image: UIImage(named: "user_img")!, username: "Luis gonzalez", userPoints: 3000),
        RankingData(image: UIImage(named: "user_img")!, username: "German gonzalez", userPoints: 2800),
        RankingData(image: UIImage(named: "user_img")!, username: "Andres gonzalez", userPoints: 2750),
        RankingData(image: UIImage(named: "user_img")!, username: "Pepe gonzalez", userPoints: 2400),
        RankingData(image: UIImage(named: "user_img")!, username: "Ibai gonzalez", userPoints: 1650),
        RankingData(image: UIImage(named: "user_img")!, username: "Siro gonzalez", userPoints: 800)
    ]
    
    static let quest: [QuestData] = [
        QuestData(title: "Ve al bar de paco", points: 20, location: bar1),
        QuestData(title: "Escanea el QR del bar artemisa", points: 15, location: bar2),
        QuestData(title: "Ve a el bar la Virgen", points: 10, location: bar3),
        QuestData(title: "Ve al bar peor valorado llamado la Lenta", points: 30, location: bar4),
        QuestData(title: "Ve a zukumbar y tomate algo", points: 20, location: bar5),
        QuestData(title: "Ve al bar la luna", points: 20, location: bar6),
        QuestData(title: "Escanea el QR del bar luisa", points: 30, location: bar1),
        QuestData(title: "Ve a cualquier bar y haz una foto", points: 10, location: bar2),
        QuestData(title: "Ve al bar mejor valorado de tu zona y sube foto", points: 30, location: bar3),
        QuestData(title: "Ve a atten y tomate algo", points: 20, location: bar4)
    ]
    static var favoritos: [beerData] = [
        beerData(titulo: "FAR WEST", ml: "750", image: UIImage(named: "cerveza-almeria")!, description: "Cerveza de Holanda de renombre conocida por todo el mundial", location: bares1),
        beerData(titulo: "LEFFE", ml: "750", image: UIImage(named: "cerveza-leffe")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares2),
        beerData(titulo: "Modelo", ml: "750", image: UIImage(named: "cerveza-Modelo")!, description: "Cerveza de Holanda de renombre conocida por todo el mundial", location: bares3),
        beerData(titulo: "La Virgen", ml: "750", image: UIImage(named: "Cervezas-la-Virgen")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares4),
        beerData(titulo: "El Alguila", ml: "750", image: UIImage(named: "cerveza-almeria")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares5),
        beerData(titulo: "FAR WEST", ml: "750", image: UIImage(named: "cerveza-leffe")!, description: "Cerveza de Mexico de renombre conocida por todo el mundial", location: bares6),
        beerData(titulo: "Life", ml: "750", image: UIImage(named: "cerveza-Modelo")!, description: "Cerveza de USA de renombre conocida por todo el mundial", location: bares7),
        beerData(titulo: "BUD LiGHT", ml: "750", image: UIImage(named: "Cervezas-la-Virgen")!, description: "Cerveza de USA de renombre conocida por todo el mundial", location: bares8)
    ]
}
