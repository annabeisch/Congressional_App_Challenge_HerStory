//
//  other_resources.swift
//  herstory
//
//  Created by Anna Beischer on 7/26/24.
//

import SwiftUI

struct other_resources: View {
    var body: some View {
        ZStack{
            Color(.systemGray5)
                .ignoresSafeArea()
            VStack{
                Text("Other Resources")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.blue)
                ScrollView {
                    VStack(spacing:30){
                        HStack {
                            Text("Welcome to the resources page! Below you can find a series of short blurbs on different organizations and websites as well as links to their web pages. These resources can serve as other places to look for women to write on.  ")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .background(Rectangle()
                            .foregroundColor(.white))
                        .cornerRadius(15)

                        .padding(.horizontal)
                        HStack {
                            Image("cfrr")
                                .resizable()
                            
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(15)
                            VStack{
                                Text("The Center for Reproductive Rights is a global legal advocacy organization, headquartered in New York City, that seeks to advance reproductive rights, such as abortion.")
                                Link("reproductiverights.org", destination: URL(string: "https://reproductiverights.org/")!)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .padding()
                        .background(Rectangle()
                            .foregroundColor(.white))
                        .cornerRadius(15)
                        .shadow(radius: 15)
                        .padding(.horizontal)
                        
                        HStack {
                            Image("wca")
                                .resizable()
                            
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(15)
                            VStack{
                                Text("The Women’s Coaching Alliance is a nonprofit organization based in the San Francisco Bay Area that teaches young women leadership skills through coaching youth sports.")
                                Link("womenscoachingalliance.org", destination: URL(string: "https://www.womenscoachingalliance.org/")!)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .padding()
                        .background(Rectangle()
                            .foregroundColor(.white))
                        .cornerRadius(15)
                        .shadow(radius: 15)
                        .padding(.horizontal)
                        
                        HStack {
                            Image("forbes")
                                .resizable()
                            
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(15)
                            VStack{
                                Text("This web page is the Forbes Richest Self-Made Women in America 2024 List and has various successful women on it and different facts about them such as career, age, and net worth.")
                                Link("forbes.com", destination: URL(string: "https://www.forbes.com/self-made-women/?sh=1641c91e6d96")!)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .padding()
                        .background(Rectangle()
                            .foregroundColor(.white))
                        .cornerRadius(15)
                        .shadow(radius: 15)
                        .padding(.horizontal)
                    
                    
                    
                 /*       ForEach(0..<20) { index in
                            Rectangle()
                                .frame(width:300, height:300).overlay(
                                    Text("\(index)").foregroundColor(.white)
                                )
                            
                        } */
                    } //closes VStack2
                }//closes Scroll View
            } // closes VStack1
        }//closes ZStack
    } //closes body
} //closes struct

#Preview {
    other_resources()
}





