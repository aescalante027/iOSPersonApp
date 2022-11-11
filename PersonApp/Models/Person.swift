//
//  Person.swift
//  PersonApp
//
//  Created by Alex Escalante on 11/9/22.
//

import Foundation

struct Person: Decodable, Identifiable, Equatable {
    
    var id: Int
    var firstname: String
    var lastname: String
    var age: Int
    
    public init() {
        id = 0
        firstname = ""
        lastname = ""
        age = 0
    }
    
    public init(id: Int, firstname: String, lastname: String, age: Int) {
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.age = age
    }
    
}
