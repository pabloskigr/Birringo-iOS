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
    
    static var baseURL = "http://localhost/Birringo/public/api/usuarios/"
    var loginUserURL = baseURL + "login"
    var registerUserURL = baseURL + "register"
    var recoverPassURL = baseURL + "recoverPass"
    var getEmployeeListURL = baseURL + "listado_empleados?api_token="
    var getEmployeeProfileURL = baseURL + "ver_perfil?api_token="
    var editUserDataURL = baseURL + "modificar_datos/"
    
    func registerUser(params: [String: Any]?, completion: @escaping (Response?, NetworkError?) -> Void) {
        
        guard let url = URL(string: registerUserURL) else {
            completion(nil, .errorURL)
            return
        }
        var urlRequest = URLRequest(url: url, timeoutInterval: 10)
        
        if let params = params {
            guard let paramsData = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                completion(nil, .badData)
                return
            }
           
            urlRequest.httpMethod = "PUT"
            urlRequest.httpBody = paramsData
        }
        let headers = [
            "Content-Type": "application/json",
            "Accept":       "application/json"
        ]
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = headers
        let urlSession = URLSession(configuration: sessionConfiguration)
        
        let networkTask = urlSession.dataTask(with: urlRequest) {
            data, response, error in
    
            guard response is HTTPURLResponse else {
                completion(nil, .errorConnection)
                return
            }
            
            guard error == nil else {
                print("error al obtener los datos")
                completion(nil, .badData)
                return
            }
            
            guard let data = data else {
                print("error al convertir a data")
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
        networkTask.resume()
    }
    
    func recoverPassword(params: [String: Any]?, completion: @escaping (Response?, NetworkError?) -> Void){
        
        guard let url = URL(string: recoverPassURL) else {
            completion(nil, .errorURL)
            return
        }
        var urlRequest = URLRequest(url: url, timeoutInterval: 10)
        
        if let params = params {
            guard let paramsData = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                completion(nil, .badData)
                return
            }
           
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = paramsData
        }
        let headers = [
            "Content-Type": "application/json",
            "Accept":       "application/json"
        ]
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = headers
        let urlSession = URLSession(configuration: sessionConfiguration)
        
        let networkTask = urlSession.dataTask(with: urlRequest) {
            data, response, error in
        
            guard response is HTTPURLResponse else {
                completion(nil, .errorConnection)
                return
            }
            
            guard error == nil else {
                print("error al obtener los datos")
                completion(nil, .badData)
                return
            }
            
            guard let data = data else {
                print("error al convertir a data")
                print(data as Any)
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
        networkTask.resume()
    }
    
    func login(params: [String: Any]?, completion: @escaping (Response?, NetworkError?) -> Void){
        
        guard let url = URL(string: loginUserURL) else {
            completion(nil, .errorURL)
            return
        }
        var urlRequest = URLRequest(url: url, timeoutInterval: 10)
        
        if let params = params {
            guard let paramsData = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                completion(nil, .badData)
                return
            }
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = paramsData
        }
        let headers = [
            "Content-Type": "application/json",
            "Accept":       "application/json"
        ]
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = headers
        let urlSession = URLSession(configuration: sessionConfiguration)
        
        let networkTask = urlSession.dataTask(with: urlRequest) {
            data, response, error in
        
            guard response is HTTPURLResponse else {
                completion(nil, .errorConnection)
                return
            }

            guard error == nil else {
                print("error al obtener los datos")
                completion(nil, .badData)
                return
            }
            
            guard let data = data else {
                print("error al convertir a data")
                print(data as Any)
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
        networkTask.resume()
    }
    
    func getEmployeeList(apiToken: String ,completion: @escaping (Response?, NetworkError?) -> Void){
        guard let url = URL(string: getEmployeeListURL + apiToken) else {
            completion(nil, .errorURL)
            return
        }
        let urlRequest = URLRequest(url:url)
        let networkTask = URLSession.shared.dataTask(with: urlRequest) {
            data, response, error in
            
            guard response is HTTPURLResponse else {
                completion(nil, .errorConnection)
                return
            }
            
            guard error == nil else {
                completion(nil, .badData)
                print("Error al obtener datos")
                return
            }
            
            guard let data = data else {
                completion(nil, .badData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                completion(response, nil)
            } catch {
                completion(nil, .badData)
                print("error al decodificar")
            }
        }
        networkTask.resume()
    }
    
    func getEmployeeProfile(apiToken: String ,completion: @escaping (Response?, NetworkError?) -> Void){
        guard let url = URL(string: getEmployeeProfileURL + apiToken) else {
            completion(nil, .errorURL)
            return
        }
        let urlRequest = URLRequest(url:url)
        let networkTask = URLSession.shared.dataTask(with: urlRequest) {
            data, response, error in
            
            guard response is HTTPURLResponse else {
                completion(nil, .errorConnection)
                return
            }
            
            guard error == nil else {
                completion(nil, .badData)
                print("Error al obtener datos")
                return
            }
            
            guard let data = data else {
                completion(nil, .badData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                completion(response, nil)
            } catch {
                completion(nil, .badData)
                print("error al decodificar")
            }
        }
        networkTask.resume()
    }
    
    func editUserData(id : String ,apiToken: String, params: [String: Any]?, completion: @escaping (Response?, NetworkError?) -> Void) {
        
        guard let url = URL(string: editUserDataURL + id + "?api_token=" + apiToken) else {
            completion(nil, .errorURL)
            return
        }
        var urlRequest = URLRequest(url: url, timeoutInterval: 10)
        
        if let params = params {
            guard let paramsData = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                completion(nil, .badData)
                return
            }
           
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = paramsData
        }
        let headers = [
            "Content-Type": "application/json",
            "Accept":       "application/json"
        ]
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = headers
        let urlSession = URLSession(configuration: sessionConfiguration)
        
        let networkTask = urlSession.dataTask(with: urlRequest) {
            data, response, error in
    
            guard response is HTTPURLResponse else {
                completion(nil, .errorConnection)
                return
            }
            
            guard error == nil else {
                print("error al obtener los datos")
                completion(nil, .badData)
                return
            }
            
            guard let data = data else {
                print("error al convertir a data")
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
        networkTask.resume()
    }
    
    
    
}
