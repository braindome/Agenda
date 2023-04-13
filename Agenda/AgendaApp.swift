//
//  AgendaApp.swift
//  Agenda
//
//  Created by Antonio on 2023-04-11.
//

import SwiftUI

@main
struct AgendaApp: App {
    @StateObject var addressBook = AddressBookViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(addressBook)
        }
    }
}
