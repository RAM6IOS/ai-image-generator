//
//  TextBox.swift
//  image12
//
//  Created by Bouchedoub Ramzi on 27/2/2023.
//

import SwiftUI
import PencilKit

struct TextBox: Identifiable {
    
    var id = UUID().uuidString
    var text :String = ""
    var  isBold :Bool = false
    var  offset:CGSize = .zero
    var position = CGSize.zero
    var dragOffset = CGSize.zero
    var lestoffset:CGSize = .zero
    var textColer:Color = .white
    
}


