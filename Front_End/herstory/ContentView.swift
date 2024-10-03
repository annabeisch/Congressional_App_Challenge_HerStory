//
//  ContentView.swift
//  herstory
//
//  Created by Anna Beischer on 7/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Top Section (Today's Review)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Today's statistic")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Only 13.6% of all Wikipedians identify as female and 1.7% as other.")
                            .font(.title2)
                            .foregroundColor(.white)
                        Text("Meaning 84.7% of Wikipedians are Male.")
                            .foregroundColor(.white.opacity(0.8))
                            .font(.body)
                        
                        NavigationLink(destination: why_wikiwoman()) {
                            Text("View more statistics here")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color.blue.opacity(0.7))
                    .cornerRadius(15)
                }
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.red]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(20)
                .padding()
                
                // Conversation Section
                VStack(alignment: .leading) {
                    Text("Get Started:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    HStack {
                        NavigationLink(destination: wiki_account_setup()) {
                            HStack {
                                Text("Set Up Your Account")
                                    .foregroundColor(.black);  Image(systemName: "person.crop.circle.fill.badge.plus")
                                    .foregroundColor(.red)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        }
                        
                        NavigationLink(destination: other_resources()) {
                            HStack {
                                Text("Find New Heros")
                                    .foregroundColor(.black)
                                Image(systemName: "books.vertical")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        }
                    }
                }
                .padding()
                
                // Your collections section
                VStack(alignment: .leading) {
                    Text("Wikithon")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    NavigationLink(destination: wikithon_setup()) {
                        HStack {
                            Text("Host a Wikithon")
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "dog.fill")
                                .foregroundColor(.orange)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                    NavigationLink(destination: examples_of_women()) {
                        HStack {
                            Text("Tell An Untold Story")
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "brain.head.profile")
                                .foregroundColor(.green)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                }
                .padding()
                
                Spacer()
                
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .navigationTitle("HerStory")
        }
    }
}


#Preview {
    ContentView()
}
