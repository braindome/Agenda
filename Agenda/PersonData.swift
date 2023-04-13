//
//  PersonData.swift
//  Agenda
//
//  Created by Antonio on 2023-04-11.
//

import Foundation
import PhotosUI

class PersonData : Identifiable, Equatable {
    
    var id = UUID()
    var name : String
    var email : String
    @Published var profilePic : Data?
    
    init(name: String, email: String, profilePic: Data? = nil) {
        self.name = name
        self.email = email
        self.profilePic = profilePic
    }

    static func == (lhs: PersonData, rhs: PersonData) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    
}
