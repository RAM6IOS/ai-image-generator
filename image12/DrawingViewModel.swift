//
//  DrawingViewModel.swift
//  image12
//
//  Created by Bouchedoub Ramzi on 23/2/2023.
//

import Foundation
import SwiftUI
import PencilKit

class DrawingViewModel:ObservableObject{
    @Published var canvas =  PKCanvasView()
    @Published  var image : UIImage?
    @Published var toolePicker = PKToolPicker()
    @Published var showtools = false
    @Published var textBoox : [TextBox] = []
    @Published var addnewBox = false
    @Published var currnerIndex :Int = 0
    
    func nillimage(){
   
           image = nil
         canvas = PKCanvasView()
            
        
        
    }
    func show(){
        showtools.toggle()
        toolePicker = PKToolPicker()
    }
    
    func canselTextView(){
     toolePicker.setVisible(true, forFirstResponder: canvas)
     canvas.becomeFirstResponder()
        withAnimation{
            addnewBox = false
        }
        textBoox.removeLast()
    }
    
}
