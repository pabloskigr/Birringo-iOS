//
//  NetworkManager.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 13/2/22.
//

import Foundation
import UIKit

enum NetworkError : Error {
    case invalidToken, badData, errorURL, errorConnection
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    private var imageCache = NSCache<NSString, UIImage>()
    
    // MARK: - Endpoints
    var loginUserURL = "login"
    var registerUserURL = "register"
    var recoverPassURL = "recoverPass"
    var getUserProfileURL = "getUserProfile?api_token="
    var uploadProfilImageURL = "uploadProfileImage?api_token="
    var getCervezasTiposMainURL = "obtenerCervezasTiposMain?api_token="
    var getCervezasPorBusquedaURL = "obtenerCervezas?api_token="
    var getPubsURL = "getPubs?api_token="
    var getPubsByNameURL = "getPubsByName?api_token="
    var getQuestsURL = "getQuests?api_token="
    var getRankingURL = "getRanking?api_token="
    var getUserPositionInRankingURL = "getUserPositionRanking?api_token="
    var editUserURL = "editUserData?api_token="
    var addBeerToFavURL = "addBeerToFavourites?api_token="
    var getFavoritesFromUserURL = "getFavouritesBeersFromUser?api_token="
    var checkQrCodeURL = "checkQuest?api_token="
    
    //MARK: - Peticion Registro.
    func registerUser(params: [String: Any]?, completion: @escaping (Response?, NetworkError?) -> Void) {
        
        Connection().connect(httpMethod: "PUT", to: registerUserURL, params: params) {
            data, error in
            
            guard let data = data else {
                print("error al convertir a data")
                completion(nil, .badData)
                return
            }
            
            guard error == nil else {
                completion(nil, .badData)
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                completion(response, nil)

            } catch {
                print("error al decodificar")
                completion(nil, .badData)
            }
        }
    }
    //MARK: - Peticion Recuperar Contraseña.
    func recoverPassword(params: [String: Any]?, completion: @escaping (Response?, NetworkError?) -> Void){
        
        Connection().connect(httpMethod: "POST", to: recoverPassURL, params: params) {
            data, error in
            
            guard let data = data else {
                print("error al convertir a data")
                completion(nil, .badData)
                return
            }
            
            guard error == nil else {
                completion(nil, .badData)
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                completion(response, nil)

            } catch {
                print("error al decodificar")
                completion(nil, .badData)
            }
        }
    }
    
    //MARK: - Peticion Login.
    func login(params: [String: Any]?, completion: @escaping (Response?, NetworkError?) -> Void){
        
        Connection().connect(httpMethod: "POST", to: loginUserURL, params: params) {
            data, error in
            
            guard let data = data else {
                print("error al convertir a data")
                completion(nil, .badData)
                return
            }
            
            guard error == nil else {
                completion(nil, .badData)
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                completion(response, nil)

            } catch {
                print("error al decodificar")
                completion(nil, .badData)
            }
        }
    }

    //MARK: - Peticion para obtener datos del usuario logueado.
    func getUserProfile(apiToken: String ,completion: @escaping (Response?, NetworkError?) -> Void){
     
        Connection().connectGetData(to: getUserProfileURL + apiToken){
            data, error in
            
            guard let data = data else {
                completion(nil, .badData)
                return
            }
            
            guard error == nil else {
                completion(nil, .badData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    completion(response, nil)
                }
            } catch {
                completion(nil, .badData)
                print("error al decodificar")
            }
            
        }
    }
    
    //MARK: - Peticion para subir imagen de perfil.
    func uploadProfileImage(apiToken: String, params: [String: Any]?, completion: @escaping (Response?, NetworkError?) -> Void) {
        
        Connection().connect(httpMethod: "POST", to: uploadProfilImageURL + apiToken, params: params) {
            data, error in
            
            guard let data = data else {
                print("error al convertir a data")
                completion(nil, .badData)
                return
            }
            
            guard error == nil else {
                print("error al obtener los datos")
                completion(nil, .badData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                completion(response, nil)

            } catch {
                print("error al decodificar")
                completion(nil, .badData)
            }
        }
  
    }
    
    //MARK: - Peticion para obtener los 5 tipos de cervezas principales del home.
    func getMainBeers(apiToken: String , tipo : String , completion: @escaping (Response?, NetworkError?) -> Void){
     
        Connection().connectGetData(to: getCervezasTiposMainURL + apiToken + "&tipo=" + tipo){
            data, error in
            
            guard let data = data else {
                completion(nil, .badData)
                return
            }
            
            guard error == nil else {
                completion(nil, .badData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    completion(response, nil)
                }
            } catch {
                completion(nil, .badData)
                print("error al decodificar")
            }
            
        }
    }
    
    //MARK: - Peticion busqueda cervezas.
    func getBeers(apiToken: String , input : String , completion: @escaping (Response?, NetworkError?) -> Void){
     
        Connection().connectGetData(to: getCervezasPorBusquedaURL + apiToken + "&busqueda=" + input){
            data, error in
            
            guard let data = data else {
                completion(nil, .badData)
                return
            }
            
            guard error == nil else {
                completion(nil, .badData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    completion(response, nil)
                }
            } catch {
                completion(nil, .badData)
                print("error al decodificar")
            }
            
        }
    }
    
    //MARK: - Peticion para obetener los bares para mostrar en el mapa.
    func getPubs(apiToken: String, completion: @escaping (Response?, NetworkError?) -> Void){
     
        Connection().connectGetData(to: getPubsURL + apiToken){
            data, error in
            
            guard let data = data else {
                completion(nil, .badData)
                return
            }
            
            guard error == nil else {
                completion(nil, .badData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    completion(response, nil)
                }
            } catch {
                completion(nil, .badData)
                print("error al decodificar")
            }
            
        }
    }
    
    //MARK: - Peticion para obtener los bares por busqueda y mostrarlos en mapa.
    func getPubsByName(apiToken: String , input : String , completion: @escaping (Response?, NetworkError?) -> Void){
     
        Connection().connectGetData(to: getPubsByNameURL + apiToken + "&busqueda=" + input){
            data, error in
            
            guard let data = data else {
                completion(nil, .badData)
                return
            }
            
            guard error == nil else {
                completion(nil, .badData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    completion(response, nil)
                }
            } catch {
                completion(nil, .badData)
                print("error al decodificar")
            }
            
        }
    }
    
    //MARK: - Peticion para obtener los Quests
    func getQuests(apiToken: String, completion: @escaping (Response?, NetworkError?) -> Void){
     
        Connection().connectGetData(to: getQuestsURL + apiToken){
            data, error in
            
            guard let data = data else {
                completion(nil, .badData)
                return
            }
            
            guard error == nil else {
                completion(nil, .badData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    completion(response, nil)
                }
            } catch {
                completion(nil, .badData)
                print("error al decodificar")
            }
            
        }
    }
    
    //MARK: - Peticion para obtener el ranking.
    func getRanking(apiToken: String, completion: @escaping (Response?, NetworkError?) -> Void){
     
        Connection().connectGetData(to: getRankingURL + apiToken){
            data, error in
            
            guard let data = data else {
                completion(nil, .badData)
                return
            }
            
            guard error == nil else {
                completion(nil, .badData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    completion(response, nil)
                }
            } catch {
                completion(nil, .badData)
                print("error al decodificar")
            }
            
        }
    }
    
    //MARK: - Peticion para obtener la posicion del usuario logueado en el ranking.
    func getUserPositionInRanking(apiToken: String, completion: @escaping (Response?, NetworkError?) -> Void){
     
        Connection().connectGetData(to: getUserPositionInRankingURL + apiToken){
            data, error in
            
            guard let data = data else {
                completion(nil, .badData)
                return
            }
            
            guard error == nil else {
                completion(nil, .badData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    completion(response, nil)
                }
            } catch {
                completion(nil, .badData)
                print("error al decodificar")
            }
            
        }
    }
    
    //MARK: - Peticion para editar los datos del usuario en la vista "Editar Perfil"
    func editUserData(apiToken: String, params: [String: Any]?, completion: @escaping (Response?, NetworkError?) -> Void) {
        
        Connection().connect(httpMethod: "POST", to: editUserURL + apiToken, params: params) {
            data, error in
            
            guard let data = data else {
                print("error al convertir a data")
                completion(nil, .badData)
                return
            }
            
            guard error == nil else {
                print("error al obtener los datos")
                completion(nil, .badData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                completion(response, nil)

            } catch {
                print("error al decodificar")
                completion(nil, .badData)
            }
        }
        
      
    }
    
    //MARK: - Peticion para obtener las imagenes de perfil, listado de cervesas etc(Se guardaran en cache para optimizar el rendimiento de la app).
    func getImageFrom(imageUrl: String, completion: @escaping (UIImage?) -> Void) {

        let cacheKey = NSString(string: imageUrl)
        if let image = imageCache.object(forKey: cacheKey) {
            completion(image)
            return
        }

        guard let url = URL(string: imageUrl) else {
            completion(nil)
            return
        }

        let urlRequest = URLRequest(url: url)
        let networkTask = URLSession.shared.dataTask(with: urlRequest) {

            data, response, error in
            guard error == nil else {
                completion(nil)
                return
            }

            guard let data = data else {
                completion(nil)
                return
            }

            guard let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            self.imageCache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        networkTask.resume()

    }
    
    //MARK: - Añadir cerveza a favoritos.
    
    func addBeerToFav (apiToken: String, params: [String: Any]?, completion: @escaping (Response?, NetworkError?) -> Void) {
        
        Connection().connect(httpMethod: "POST", to: addBeerToFavURL + apiToken, params: params) {
            data, error in
            
            guard let data = data else {
                print("error al convertir a data")
                completion(nil, .badData)
                return
            }
            
            guard error == nil else {
                print("error al obtener los datos")
                completion(nil, .badData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                completion(response, nil)

            } catch {
                print("error al decodificar")
                completion(nil, .badData)
            }
        }
    }
    
    //MARK: - Obtener cervezas favoritas de usuario.
    
    func getFavsFromUser(apiToken: String , completion: @escaping (Response?, NetworkError?) -> Void){
        
        Connection().connectGetData(to: getFavoritesFromUserURL  + apiToken){
            data, error in
            
            guard let data = data else {
                completion(nil, .badData)
                return
            }
            
            guard error == nil else {
                completion(nil, .badData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    completion(response, nil)
                }
            } catch {
                completion(nil, .badData)
                print("error al decodificar")
            }
            
        }
    }
    
    func checkQrCode(apiToken: String, params: [String: Any]?, completion: @escaping (Response?, NetworkError?) -> Void) {
        
        Connection().connect(httpMethod: "POST", to: checkQrCodeURL + apiToken, params: params) {
            data, error in
            
            guard let data = data else {
                print("error al convertir a data")
                completion(nil, .badData)
                return
            }
            
            guard error == nil else {
                print("error al obtener los datos")
                completion(nil, .badData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                completion(response, nil)

            } catch {
                print("error al decodificar")
                completion(nil, .badData)
            }
        }
        
      
    }
    
    
    
}
