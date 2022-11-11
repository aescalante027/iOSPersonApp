//
//  ContentView.swift
//  PersonApp
//
//  Created by Alex Escalante on 11/9/22.
//

import SwiftUI

struct SinglePersonView: View {
    @State private var id: String = ""
    @State private var person: Person?
    @State var labelText = "Person: No Person Loaded"
    
    var body: some View {
        VStack {
            TextField("Find User By ID",
                      text: $id)
            Text(labelText)
            Button{
                person = display(id: id)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    updateLabelText()
                }
            } label: {
                Label("Submit", systemImage: "something")
            }
        }
        .padding()
    }
    
    func display(id: String) -> Person? {
        let api = PersonAPIController()
        if !id.isEmpty {
            api.getSinglePersonData(id: Int(id)!) { result in
                if result == nil {
                    person = nil
                } else {
                    person = result
                }
            }
        }
        return person
    }

    func updateLabelText() {
        if let myPerson = person {
            labelText = "Person: " + myPerson.firstname + " " + myPerson.lastname
        }
        else {
            labelText = "NO PERSON FOUND WITH THIS ID"
        }
    }
}
