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
}
