//
//  WikithonConfirmationView.swift
//  herstory
//
//  Created by Anna Beischer on 9/8/24.
//

import SwiftUI

struct WikithonConfirmationView: View {
    let wikithon: Wikithon

    var body: some View {
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
