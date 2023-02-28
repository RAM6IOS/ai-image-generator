//
//  DrawingScren.swift
//  image12
//
//  Created by Bouchedoub Ramzi on 23/2/2023.
//

import SwiftUI
import PencilKit

struct DrawingScren: View {
    @EnvironmentObject var model : DrawingViewModel
    
    var body: some View {
       
        ZStack{
            GeometryReader{ proxy -> AnyView in
                let size = proxy.frame(in: .global).size
             return   AnyView(
                canvert(canvas: $model.canvas, image: $model.image, toolePicker: $model.toolePicker, showtools: $model.showtools, rect: size)
                    
                )
            }
                
        }
    }
}

struct DrawingScren_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}

struct canvert: UIViewRepresentable {
   //@Binding var image: UIImage?
   // typealias  drawingView = PKCanvasView
   // let tpplPiker = PKToolPicker()
    @Binding var canvas :  PKCanvasView
    @Binding var image: UIImage?
    @Binding var toolePicker : PKToolPicker
    @Binding var showtools: Bool
    var rect : CGSize
    func makeUIView(context: Context) -> PKCanvasView{
        
        canvas.drawingPolicy = .anyInput
        canvas.isOpaque = false
        canvas.backgroundColor = .clear
        
            if let image = image {
                let imageView = UIImageView(image: image)
                imageView.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
                imageView.contentMode = .scaleAspectFit
                imageView.clipsToBounds = true
                
                let subView = canvas.subviews[0]
                subView.addSubview(imageView)
                subView.sendSubviewToBack(imageView)
                
                
            }
        toolePicker.setVisible(true, forFirstResponder: canvas)
        toolePicker.addObserver(canvas)
        canvas.becomeFirstResponder()
        
        return canvas
        
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
       
    }
}
