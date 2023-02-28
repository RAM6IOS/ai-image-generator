//
//  DrawingVie.swift
//  image12
//
//  Created by Bouchedoub Ramzi on 23/2/2023.
//

import SwiftUI
import PencilKit

struct DrawingVie: View {
    @State private var image : UIImage?
    @State private var showSheet = false
    
    var body: some View {
        VStack{
                DrawingView()
        }
    }
}

struct DrawingVie_Previews: PreviewProvider {
    static var previews: some View {
        DrawingVie()
    }
}


struct DrawingView: UIViewRepresentable {
   //@Binding var image: UIImage?
    typealias  drawingView = PKCanvasView
    let tpplPiker = PKToolPicker()

    func makeUIView(context: Context) -> PKCanvasView {
        let drawingView2 = PKCanvasView()
        drawingView2.drawingPolicy = PKCanvasViewDrawingPolicy.anyInput
        drawingView2.backgroundColor = .white
        drawingView2.tool = PKInkingTool(.pen, color: .black, width: 10)
        
        tpplPiker.addObserver(drawingView2)
        tpplPiker.setVisible(true, forFirstResponder: drawingView2)
        drawingView2.becomeFirstResponder()
        return drawingView2
        /*
        drawingView2.backgroundColor = .white
        drawingView2.tool = PKInkingTool(.pen, color: .black, width: 10)

        let toolPicker = PKToolPicker()
        toolPicker.addObserver(drawingView2)
        toolPicker.setVisible(true, forFirstResponder: drawingView2)
        

        
         */
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
       // if let image = image {
           // uiView.drawing = PKDrawing(image)
        //}
        
    }
}
/*
struct ContentView: View {
    

    var body: some View {
        VStack {
            DrawingView(image: $image)
                .frame(width: 300, height: 300)

            Button("Save Drawing") {
                if let drawing = drawingView.drawing {
                    let data = try? NSKeyedArchiver.archivedData(withRootObject: drawing, requiringSecureCoding: true)
                    let encodedDrawing = PKDrawing(data: data!)
                    image = encodedDrawing.image(from: encodedDrawing.bounds, scale: UIScreen.main.scale)
                }
            }
        }
    }
}

*/
