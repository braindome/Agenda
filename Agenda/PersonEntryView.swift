//
//  PersonEntryView.swift
//  Agenda
//
//  Created by Antonio on 2023-04-12.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers
import PhotosUI

struct PersonEntryView : View {
    var friend : PersonData?
    
    @EnvironmentObject var addressBook : AddressBookViewModel
    
    @State var name : String = ""
    @State var email : String = ""
    @State var selectedPic : [PhotosPickerItem] = []
    @State private var profilePicData: Data? = nil
    @State var data : Data?
    
    @Environment(\.presentationMode) var presentationMode
    
    var body : some View {
        HStack {
            Spacer(minLength: 70)
            VStack {
                Text("Enter name")
                TextField("Name", text: $name)
                Text("Enter email")
                TextField("Email", text: $email)
                if let data = data, let uiimage = UIImage(data: data) {
                    Image(uiImage: uiimage)
                        .resizable().scaledToFit()
                }
                PhotosPicker(
                    selection: $selectedPic,
                    maxSelectionCount: 1,
                    matching: .images
                ) {
                    Text("Select Photo")
                }
                .onChange(of: selectedPic) { newValue in
                    guard let pic = selectedPic.first else {
                        return
                    }
                    pic.loadTransferable(type: Data.self) { result in
                        switch result {
                        case .success(let data):
                            if let data = data {
                                self.data = data
                            } else {
                                print("No data")
                            }
                        case .failure(let failure):
                            fatalError("\(failure)")
                        }
                    }
                }
            }
            .onAppear(perform: setFields)
            .navigationBarItems(trailing: Button("Save") {
                saveEntry()
                presentationMode.wrappedValue.dismiss()
            })
            Spacer(minLength: 70)
        }
    }
    
    
    private func saveEntry() {
        if let friend = friend {
            // uppdatera gammal person
            addressBook.update(person: friend, with: name, with: email, with: data)
        } else {
            // skapa ny person
            let newPerson = PersonData(name: name, email: email, profilePic: data)
            addressBook.friendList.append(newPerson)
        }
    }
    
    private func setFields() {
        if let friend = friend {
            name = friend.name
            email = friend.email
            data = friend.profilePic
        }
    }
    
    private func loadImage() {
        if let profilePicData = profilePicData {
            friend?.profilePic = profilePicData
            if let uiImage = UIImage(data: profilePicData) {
                print("Image loaded")
            }
        }
    }
    
    
}

struct PersonEntryView_Previews: PreviewProvider {
    static var previews: some View {
        PersonEntryView()
    }
}



