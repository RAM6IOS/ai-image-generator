//
//  ImageGeneratorViewModel.swift
//  image12
//
//  Created by Bouchedoub Ramzi on 2/3/2023.
//

import Foundation
import SwiftUI
import OpenAIKit

final class ImageGeneratorViewModel: ObservableObject {
    
    private var openAI: OpenAI?
    let apiKey = "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"
    
    func setup() {
        openAI = OpenAI(
            Configuration(
                organizationId: "Personal",
                apiKey: apiKey
            )
        )
    }
    
    func generateImage(from prompt: String) async -> UIImage? {
        guard let openAI = openAI else {
            return nil
        }
        
        let imageParameters = ImageParameters(
            prompt: prompt,
            resolution: .medium,
            responseFormat: .base64Json
        )
    
        do {
            let result = try await openAI.createImage(parameters: imageParameters)
            let imageData = result.data[0].image
            let image = try openAI.decodeBase64Image(imageData)
            return image
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
   
}

