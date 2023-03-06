//
//  FilterViewModel.swift
//  image12
//
//  Created by Bouchedoub Ramzi on 2/3/2023.
//

import Foundation
import CoreImage
import CoreImage.CIFilterBuiltins
import UIKit

class FilterViewModel : NSObject, ObservableObject {
    @Published  var filterIntensity = 0.5

    @Published  var showingImagePicker = false
    @Published var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()

    @Published var showingFilterSheet = false
    @Published var lodimage = false
    @Published  var image : UIImage?
    @Published var showView = "Crystallize"
    @Published var showshit:Bool = false
    
    func nillimage(){
           image = nil
    }
    func loadImage() {
        guard let inputImage = image else { return }


            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    func lodimage2(){
        lodimage = true
        if lodimage {
            let inputKeys = currentFilter.inputKeys

            if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(0, forKey: kCIInputIntensityKey) }
            if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(0, forKey: kCIInputRadiusKey) }
            if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(0, forKey: kCIInputScaleKey) }
        }
        
    }
    func applyProcessing() {
            let inputKeys = currentFilter.inputKeys

            if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
            if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
            if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        

            guard let outputImage = currentFilter.outputImage else { return }

            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                let uiImage = UIImage(cgImage: cgimg)
               image = uiImage
               
            }
        }
    func setFilter(_ filter: CIFilter) {
            currentFilter = filter
            loadImage()
        }
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
    
}
