//
//  gesturesview.swift
//  image12
//
//  Created by Bouchedoub Ramzi on 28/2/2023.
//

import SwiftUI

struct ContentView2: View {
    // For long press gesture
    @State private var isPressed = false

    // For drag gesture
  
    @State private var position = CGSize.zero
    @GestureState private var longPressTap = false
    @GestureState private var dragOffset = CGSize.zero

    var body: some View {
        Image(systemName: "star.circle.fill")
                .font(.system(size: 100))
                .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height)
                .animation(.easeInOut, value: dragOffset)
                .foregroundColor(.green)
                .gesture(
                    DragGesture()
                        .updating($dragOffset, body: { (value, state, transaction) in

                            state = value.translation
                        })
                        .onEnded({ (value) in
                            self.position.height += value.translation.height
                            self.position.width += value.translation.width
                        })
                )
    }
}


struct gesturesview_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
