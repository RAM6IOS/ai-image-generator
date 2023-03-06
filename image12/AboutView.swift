//
//  AboutView.swift
//  image12
//
//  Created by Bouchedoub Ramzi on 6/3/2023.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView{
            VStack{
                Image("imago")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    .padding(.top, 44)
                Text("Imago")
                    .fontWeight(Font.Weight.heavy)
                    .font(.system(size: 30))
                //.foregroundColor(Color.cadcoler)
                Text("""
 imago it an app you can create realistic images and art from a description in natural language and save , shared with friend
 """)
                .padding()
                Spacer()
            }
            .toolbar {
                            ToolbarItem( placement: .navigationBarLeading) {
                                Button(action: {
                                    
                                    presentationMode.wrappedValue.dismiss()
                                    
                                }) {
                                    Text("Close")
                                        .font(.system(size: 20))
                                        .foregroundColor(.black)
                                    
                                }
                                
                            }
        }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
