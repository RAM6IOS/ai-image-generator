//
//  GetStarted.swift
//  image12
//
//  Created by Bouchedoub Ramzi on 6/3/2023.
//

import SwiftUI

struct GetStarted: View {
    //@AppStorage("ShowOnboarding") var ShowOnboarding = true
    @Binding var ShowOnboarding:Bool
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            VStack{
               
                VStack{
                    Text("Imago")
                        .foregroundColor(.white)
                        .font(
                            .system(size: 30)
                            .weight(.heavy)
                        )
                    
                        .padding(.vertical , 20)
                    
                    Text("Imago is Ai  Generator Turn words into artworks")
                        .foregroundColor(.white)
                        .font(
                            .system(size: 30)
                        )
                        .padding( 20)
                    Image("twe")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 350 )
                        .cornerRadius(14)
                }
                Spacer()
                Button{
                    ShowOnboarding.toggle()
                    
                } label:
                {
                    Text("Get Started")
                        .bold()
                        .font(.title3)
                        .frame(width: 350, height: 40)
                        .foregroundColor(.white)
                        .background(Color.newColor)
                        .cornerRadius(10)
                }
                Spacer()
            }
        }
    }
}

