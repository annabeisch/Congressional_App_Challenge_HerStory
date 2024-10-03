//
//  wiki_account_setup.swift
//  herstory
//
//  Created by Anna Beischer on 7/26/24.
//

import SwiftUI

struct wiki_account_setup: View {
    var body: some View {
        ZStack{
            Color(.systemGray5)
                .ignoresSafeArea()
            ScrollView{
                VStack{
                    Text("How to Setup a Wikipedia Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.red)
                    
                    Spacer()
                    
                    Text("Setting up a Wikipedia account is super quick and easy to do! ")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Rectangle()
                            .foregroundColor(.white))
                        .cornerRadius(15)
                        .padding(.horizontal)
                    
                    VStack{
                        
                        Text("First head to [Wikipedia](https://en.wikipedia.org/wiki/Main_Page) and press the 'create account' button in the top right corner.")
                        Image("Screenshot 2024-08-19 at 8.07.01 PM")
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    }//closes VStack
                    
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Rectangle()
                        .foregroundColor(.white))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    VStack{
                        Text("Once you've navigated to that page it will ask you for a username, password, and the best email address if you ever need to recover your account. Then it will have you do a quick CAPTCHA Security check and click 'Create your account'.")
                        
                        Image("Screenshot 2024-08-19 at 8.07.51 PM")
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        
                        Text("And that is it! You've successfuly created your wikipedia account! ")
                    }
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding()
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Rectangle()
                                .foregroundColor(.white))
                            .cornerRadius(15)
                            .padding(.horizontal)
                    }
                } //closes VStack
            }
        } //closes ZStack
    }//closes body



#Preview {
    wiki_account_setup()
}
