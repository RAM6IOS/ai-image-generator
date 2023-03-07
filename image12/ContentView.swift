//
//  ContentView.swift
//  image12
//
//  Created by Bouchedoub Ramzi on 23/2/2023.
//

import SwiftUI

struct ContentView2: View {
    @State private var image : UIImage?
    @State private var showSheet = false
    @StateObject var model = DrawingViewModel()
    @State private var isPressed = false
    var body: some View {
        ZStack{
            NavigationView{
                VStack{
                    if model.image != nil{
                        ZStack{
                            DrawingScren()
                                .environmentObject(model)
                        }
                    }
                    
                    Text("Change photo")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)), Color(#colorLiteral(red: 0.5647058824, green: 0.462745098, blue: 0.9058823529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(16)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .onTapGesture {
                            showSheet = true
                            model.nillimage()
                        }
                        
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Deleet") {
                            model.nillimage()
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Show Tools") {
                            model.textBoox.append(TextBox())
                            model.currnerIndex = model.textBoox.count - 1
                            withAnimation{
                                model.addnewBox.toggle()
                            }
                            model.toolePicker.setVisible(false, forFirstResponder: model.canvas)
                            model.canvas.resignFirstResponder()
                        }
                    }
                }
            }
            if model.addnewBox {
                Color.black.opacity(0.75)
                    .ignoresSafeArea()
                TextField("Type Hera", text: $model.textBoox[model.currnerIndex].text)
                    .font(.system(size: 35))
                    .colorScheme(.dark)
                    .foregroundColor(model.textBoox[model.currnerIndex].textColer)
                    .padding()
                HStack{
                    Button{
                        model.toolePicker.setVisible(true, forFirstResponder: model.canvas)
                       model.canvas.becomeFirstResponder()
                        withAnimation{
                            model.addnewBox = false
                        }
                    }label: {
                        Text("add")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                    Button{
                        model.canselTextView()
                    }label: {
                        Text("Cansel")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .overlay{
                    ColorPicker("", selection: $model.textBoox[model.currnerIndex].textColer)
                        .labelsHidden()
                }
                .frame(maxHeight:.infinity , alignment: .top)
                
            }
            
        }
        .sheet(isPresented: $showSheet) {
           
        }
    }
    
    func getIndex(textbox:TextBox)-> Int{
        let index = model.textBoox.firstIndex{ (boox) -> Bool in
            return textbox.id == boox.id
        } ?? 0
        return index
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
