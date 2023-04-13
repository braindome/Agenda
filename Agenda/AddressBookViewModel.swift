//
//  AddressBook.swift
//  Agenda
//
//  Created by Antonio on 2023-04-11.
//

import Foundation
import PhotosUI

class AddressBookViewModel : ObservableObject {
    
    @Published var friendList = [PersonData]()
    
    init() {
        addMockData()
    }
    
    func addMockData() {
        friendList.append(PersonData(name: "Daniele B", email: "balestrieri@dualog.no"))
        friendList.append(PersonData(name: "Nicola", email: "nik76@allianz.it"))
        friendList.append(PersonData(name: "Daniele P", email: "peluzzo@blogger.it"))
        friendList.append(PersonData(name: "Riccardo", email: "rik@truemetal.it"))
        friendList.append(PersonData(name: "Pier", email: "pier@brutalassault.cz"))
    }
    
    func update(person: PersonData, with name: String, with email: String, with profilePicData: Data?) {
        if let index = friendList.firstIndex(of: person) {
            friendList[index].name = name
            friendList[index].email = email
            if let profilePicData = profilePicData {
                friendList[index].profilePic = profilePicData
            } else {
                friendList[index].profilePic = nil
            }
        }

    }
}
