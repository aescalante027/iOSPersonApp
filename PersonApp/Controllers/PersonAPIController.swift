//
//  PersonAPIController.swift
//  PersonApp
//
//  Created by Alex Escalante on 11/9/22.
//

import Foundation

class PersonAPIController: ObservableObject {
    
    private let urlSession = URLSession.shared
    private let BASE_URL = "http://unicorn.local:5050"
    
    func getSinglePersonData(id: Int, completion: @escaping (Person?) -> Void) {
        let stringUrl = BASE_URL + "/person/" + String(id)
        guard let URL = URL(string: stringUrl) else {
            // this should work in the first place
            return
        }
        let urlRequest = URLRequest(url: URL)
        
        urlSession.dataTask(with: urlRequest) { data, response, error in
            guard error == nil,
                  let data = data,
                  let person = try? JSONDecoder().decode(Person.self, from: data) else {
                    debugPrint("Failed to get person")
                    completion(nil)
                    return
                }
            debugPrint(person)
            completion(person)
        }.resume()
    }
    
    func getAllPeopleData(completion: @escaping ([String:Any]) -> Void) {
        let stringURL = BASE_URL + "/person/all"
        guard let URL = URL(string: stringURL) else {
            // this should work in the first place
            return
        }
        let urlRequest = URLRequest(url: URL)
        
        urlSession.dataTask(with: urlRequest) { data, response, error in
            guard error == nil,
                  let data = data,
                  let people = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    debugPrint("Failed to get all people data")
                    return
                  }
            debugPrint(people)
            completion(people)
        }.resume()
    }
    
    func updatePersonAge(id: Int, age: Int, completion: @escaping (Person) -> Void) {
        let stringURL = BASE_URL + "/person/" + String(id) + "/age/" + String(age)
        guard let URL = URL(string: stringURL) else {
            return
        }
        var urlReqeust = URLRequest(url: URL)
        urlReqeust.httpMethod = "PUT"
        
        urlSession.dataTask(with: urlReqeust) { data, response, error in
            guard error == nil,
                  let data = data,
                  let person = try? JSONDecoder().decode(Person.self, from: data) else {
                    debugPrint("Failed to get person")
                    return
            }
            debugPrint(person)
            completion(person)
        }.resume()
    }
    
    func updatePersonLastName(id: Int, lastname: String, completion: @escaping (Person) -> Void) {
        let stringURL = BASE_URL + "/person/" + String(id) + "/lastname/" + lastname
        guard let URL = URL(string: stringURL) else {
            return
        }
        var urlReqeust = URLRequest(url: URL)
        urlReqeust.httpMethod = "PUT"
        
        urlSession.dataTask(with: urlReqeust) { data, response, error in
            guard error == nil,
                  let data = data,
                  let person = try? JSONDecoder().decode(Person.self, from: data) else {
                    debugPrint("Failed to get person")
                    return
            }
            debugPrint(person)
            completion(person)
        }.resume()
    }
}
