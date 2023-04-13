//
//  ContentView.swift
//  Agenda
//
//  Created by Antonio on 2023-04-11.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @EnvironmentObject var addressBook : AddressBookViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List() {
                    ForEach(addressBook.friendList) { friend in
                        NavigationLink(destination:
                                        PersonEntryView(friend: friend)) {
                            RowView(person: friend)
                        }
                    }
                }
                .navigationTitle("Agenda")
                .navigationBarItems(trailing:
                                        NavigationLink(destination: PersonEntryView()) {
                    Image(systemName: "plus.circle")
                })
            }
        }
    }
    
    struct RowView : View {
        let person : PersonData
        
        var body : some View {
            HStack {
                if let profilePicData = person.profilePic,
                   let uiImage = UIImage(data: profilePicData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                } else {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
                Text(person.name)
                Spacer()
                Text(person.email)
            }
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let agenda = AddressBookViewModel()
        ContentView().environmentObject(agenda)
    }
}




