//
//  why_wikiwoman.swift
//  herstory
//
//  Created by Anna Beischer on 7/26/24.
//

import SwiftUI

struct why_wikiwoman: View {
    var body: some View {
        ZStack{
            Color(.systemGray5)
                .ignoresSafeArea()
            ScrollView{
                VStack {
                    Text("Wikipedia Statistics")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.red)
                    
                    
                    
                    HStack {
                        Text("Wikipedia is the 5th most visited website in the world with 6.7 billion people visiting it monthly, and has 113,449 active wikipedians.")
                            .font(.title2)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(Rectangle()
                        .foregroundColor(.red))
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Only 13.6% of all Wikipedians identify as female and 1.7% as other. Meaning 84.7% of Wikipedians are Male.")
                            .font(.title2)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(Rectangle()
                        .foregroundColor(.red))
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Of English Wikipedia pages only 19.8% are on women.")
                            .font(.title2)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(Rectangle()
                        .foregroundColor(.red))
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Since Wikipedia is one of the most visited websites in the world, it's likely one of the sites that is being used to train various AIs and if it's biased then those AIs will inherit its biases. This is why it's critical that we contribute to making sites like wikipedia less biased so that AIs being trained by the information are learning accurate information that represents women and their accomplishments. ")
                            .font(.title2)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(Rectangle()
                        .foregroundColor(.red))
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    why_wikiwoman()
}
