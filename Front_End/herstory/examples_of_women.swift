//
//  examples_of_women.swift
//  herstory
//
//  Created by Anna Beischer on 7/26/24.
//

import SwiftUI

struct examples_of_women: View {
    @StateObject private var viewModel = HeroesViewModel()
    var body: some View {
        ZStack{
            Color(.systemGray5)
                .ignoresSafeArea()
            
            Text("Possible Women To Write About")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Color.green)
            Spacer()
            
            NavigationView {
                        List(viewModel.heroes) { hero in
                            VStack(alignment: .leading) {
                                Text(hero.name)
                                    .font(.headline)
                                Text("Added on: \(hero.added_date)")
                                    .font(.subheadline)
                                Text("Status: \(hero.completion_status)")
                                    .font(.subheadline)
                                    .foregroundColor(hero.completion_status == "Pending" ? .red : .green)
                            }
                        }
                        .navigationTitle("Unsung Heroes")
                        .onAppear {
                            viewModel.fetchHeroes()
                        }
                    }
        }//closes ZStack
    } //closes body
} //closes struct

#Preview {
    examples_of_women()
}
