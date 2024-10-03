//
//  wikithon_setup.swift
//  herstory
//
//  Created by Anna Beischer on 7/26/24.
//

import SwiftUI

struct wikithon_setup: View {
    @StateObject private var viewModel = HeroesViewModel()
    @State private var name: String = ""
        @State private var createdDate: Date = Date()
        @State private var numberOfHeroes: Double = 10
    
    @State private var showConfirmation: Bool = false
    
    var body: some View {
        ZStack{
            Color(.systemGray5)
                .ignoresSafeArea()
        
                
            if !showConfirmation {
                VStack {
                    Text("Set up a wikithon!")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.orange)
                    TextField("Enter Wikithon name", text: $name)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    DatePicker("Select Date", selection: $createdDate, displayedComponents: .date)
                        .padding()
                    VStack {
                        Text("Number of Unsung Heroes: \(Int(numberOfHeroes))")
                        Slider(value: $numberOfHeroes, in: 1...50, step: 1)
                            .padding()
                    }
                    Button("Create Wikithon") {
                        showConfirmation = true
                        viewModel.createWikithon(name: name, createdDate: createdDate, n: Int(numberOfHeroes))
                        
                    }
                    .padding()
                    
                    
                }
                .padding()
            }
            else {
                if let wikithon = viewModel.createdWikithon {
                    
                    if let wikithon = viewModel.createdWikithon {
                        
                        VStack {
                            Text("Wikithon Created!")
                                .font(.title)
                                .padding()

                            Text(wikithon.name)
                                .font(.headline)

                            // Share Link for the Wikithon
                            if let shareURL = URL(string: "http://herstoryCACapp.com/wikithon/\(wikithon.id)") {
                                ShareLink(item: shareURL, message: Text("Check out this Wikithon!"))
                                    .padding()
                            }

                            Text("Unsung Heroes")
                                .font(.title2)
                                .padding(.top)

                            // List of Unsung Heroes
                            List(wikithon.unsung_heroes) { hero in
                                VStack(alignment: .leading) {
                                    Text(hero.name)
                                        .font(.headline)
                                    Text("Added on: \(hero.added_date)")
                                    Text("Status: \(hero.completion_status)")
                                        .foregroundColor(hero.completion_status == "Pending" ? .red : .green)
                                }
                            }
                        }
                        .padding()
                    }
                    
                }
            }
        }

    }//closes body
}

#Preview {
    wikithon_setup()
}
