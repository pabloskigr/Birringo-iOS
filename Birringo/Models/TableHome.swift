//
//  TableHome.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 25/1/22.
//

import Foundation
import UIKit
//PRUEBA DATA LOCAL
struct Data {
    var titulo: String
    var ml:String
    var image:UIImage
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
    //habira que añadir localizacion y descripcion para el detail.
}
struct FavotitosData {
    var title: String
    var image: UIImage
}

struct MockData{
    
    static let datos: [Data] = [
        Data(titulo: "Heineken", ml: "750", image: UIImage(named: "beer_image")!),
        Data(titulo: "Estrella", ml: "500", image: UIImage(named: "beer_image")!),
        Data(titulo: "Cerveza 1", ml: "700", image: UIImage(named: "beer_image")!),
        Data(titulo: "Cerveza 2", ml: "600", image: UIImage(named: "beer_image")!),
        Data(titulo: "Cerveza 3", ml: "650", image: UIImage(named: "beer_image")!),
        Data(titulo: "Cerveza 4", ml: "450", image: UIImage(named: "beer_image")!),
        Data(titulo: "Cerveza 5", ml: "550", image: UIImage(named: "beer_image")!),
        Data(titulo: "Cerveza 6", ml: "600", image: UIImage(named: "beer_image")!),
        Data(titulo: "Cerveza 7", ml: "650", image: UIImage(named: "beer_image")!),
        Data(titulo: "Cerveza 8", ml: "700", image: UIImage(named: "beer_image")!)
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
        QuestData(title: "Ve al bar de paco", points: 20),
        QuestData(title: "Escanea el QR del bar artemisa", points: 30),
        QuestData(title: "Ve a cualquier bar y haz una foto", points: 10),
        QuestData(title: "Ve al bar peor valorado de tu zona y sube foto", points: 30),
        QuestData(title: "Ve a zukumbar y tomate algo", points: 20),
        QuestData(title: "Ve al bar de paco", points: 20),
        QuestData(title: "Escanea el QR del bar luisa", points: 30),
        QuestData(title: "Ve a cualquier bar y haz una foto", points: 10),
        QuestData(title: "Ve al bar mejor valorado de tu zona y sube foto", points: 30),
        QuestData(title: "Ve a atten y tomate algo", points: 20)
    ]
    static let favoritos: [FavotitosData] = [
        FavotitosData(title: "FAR WEST", image: UIImage(named: "cerveza-almeria")!),
        FavotitosData(title: "LEFFE", image: UIImage(named: "cerveza-leffe")!)
    ]
}
