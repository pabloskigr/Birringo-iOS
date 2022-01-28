//
//  TableHome.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 25/1/22.
//

import Foundation
import UIKit
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
}

struct PerfilData {
    var title: String
    var image: UIImage
}

struct RankingData {
    var image : UIImage
    var username : String
    var userPoints : Int
}

struct QuestData {
    var title : String
    var points : Int
    var localizacion : String
    //habira que añadir localizacion y descripcion para el detail.
}
struct FavotitosData {
    var title: String
    var image: UIImage
}

struct MockData{
    
    static let datos: [beerData] = [
        beerData(titulo: "Heineken", ml: "750", image: UIImage(named: "beer_image")!, description: "Cerveza de Holanda de renombre conocida por todo el mundial", location: bares1),
        beerData(titulo: "Estrella Galicia", ml: "750", image: UIImage(named: "beer_image")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares2),
        beerData(titulo: "Leffe", ml: "750", image: UIImage(named: "beer_image")!, description: "Cerveza de Holanda de renombre conocida por todo el mundial", location: bares3),
        beerData(titulo: "La Virgen", ml: "750", image: UIImage(named: "beer_image")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares4),
        beerData(titulo: "El Alguila", ml: "750", image: UIImage(named: "beer_image")!, description: "Cerveza de Española de renombre conocida por todo el mundial", location: bares5),
        beerData(titulo: "Corona", ml: "750", image: UIImage(named: "beer_image")!, description: "Cerveza de Mexico de renombre conocida por todo el mundial", location: bares6),
        beerData(titulo: "Life", ml: "750", image: UIImage(named: "beer_image")!, description: "Cerveza de USA de renombre conocida por todo el mundial", location: bares7),
        beerData(titulo: "BUD LiGHT", ml: "750", image: UIImage(named: "beer_image")!, description: "Cerveza de USA de renombre conocida por todo el mundial", location: bares8)
    ]
    static let bares1: [Bares] = [
        Bares(title: "La virgen"),
        Bares(title: "El Burro"),
        Bares(title: "La Laguna"),
    ]
    static let bares2: [Bares] = [
        Bares(title: "La virgen"),
        Bares(title: "La Leña"),
        Bares(title: "La mesa"),
    ]
    static let bares3: [Bares] = [
        Bares(title: "El meson"),
        Bares(title: "El Rincon de Paco"),
        Bares(title: "Bar"),
    ]
    static let bares4: [Bares] = [
        Bares(title: "El cienMontaditos"),
        Bares(title: "La Sureña"),
        Bares(title: "Artico"),
    ]
    static let bares5: [Bares] = [
        Bares(title: "Artico"),
        Bares(title: "La Maria"),
        Bares(title: "La Negra"),
    ]
    static let bares6: [Bares] = [
        Bares(title: "La Blanca"),
        Bares(title: "La Lenta"),
        Bares(title: "La virgen"),
    ]
    static let bares7: [Bares] = [
        Bares(title: "El norte"),
        Bares(title: "Los Nachos"),
        Bares(title: "La virgen"),
    ]
    static let bares8: [Bares] = [
        Bares(title: "La Marina"),
        Bares(title: "La Juana"),
        Bares(title: "La Luna"),
    ]
    
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
        QuestData(title: "Ve al bar de paco", points: 20, localizacion: "Bar de Paco"),
        QuestData(title: "Escanea el QR del bar artemisa", points: 30, localizacion: "Bar Artemisa"),
        QuestData(title: "Ve a cualquier bar y haz una foto", points: 10, localizacion: "Culaquier bar"),
        QuestData(title: "Ve al bar peor valorado de tu zona y sube foto esnea el codigo", points: 30, localizacion: "Var peor valorado de tu zona"),
        QuestData(title: "Ve a zukumbar y tomate algo", points: 20, localizacion: "Zukumbar"),
        QuestData(title: "Ve al bar de paco", points: 20, localizacion: "Bar de Paco"),
        QuestData(title: "Escanea el QR del bar luisa", points: 30, localizacion: "Bar de Luisa"),
        QuestData(title: "Ve a cualquier bar y haz una foto", points: 10, localizacion: "Culaquier bar"),
        QuestData(title: "Ve al bar mejor valorado de tu zona y sube foto", points: 30, localizacion: "Bar mejor valorado de tu zona"),
        QuestData(title: "Ve a atten y tomate algo", points: 20, localizacion: "Bar Atten")
    ]
    static var favoritos: [FavotitosData] = [
        FavotitosData(title: "FAR WEST", image: UIImage(named: "cerveza-almeria")!),
        FavotitosData(title: "LEFFE", image: UIImage(named: "cerveza-leffe")!),
        FavotitosData(title: "Modelo", image: UIImage(named: "cerveza-Modelo")!),
        FavotitosData(title: "La Virgen", image: UIImage(named: "Cervezas-la-Virgen")!),
        FavotitosData(title: "FAR WEST", image: UIImage(named: "cerveza-almeria")!),
        FavotitosData(title: "LEFFE", image: UIImage(named: "cerveza-leffe")!),
        FavotitosData(title: "Modelo", image: UIImage(named: "cerveza-Modelo")!),
        FavotitosData(title: "La Virgen", image: UIImage(named: "Cervezas-la-Virgen")!),
        FavotitosData(title: "FAR WEST", image: UIImage(named: "cerveza-almeria")!)
    ]
}
