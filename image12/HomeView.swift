//
//  HomeView.swift
//  image12
//
//  Created by Bouchedoub Ramzi on 2/3/2023.
//


import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct HomeView: View {
    @StateObject private var viewModel = ImageGeneratorViewModel()
    @State var prompt: String = ""
    @State var generatedImage: UIImage?
    @State var isLoading: Bool = false
    @StateObject var model = DrawingViewModel()
   
        @State private var filterIntensity = 0.5

        @State private var showingImagePicker = false
        @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
        let context = CIContext()

        @State private var showingFilterSheet = false
    var body: some View {
        NavigationView{
            ZStack {
                if isLoading {
                    ProgressView()
                        .tint(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("backgroundColor"))
                } else {
                   
                    VStack {
                        Text("DALL-E IMAGE GENERATOR")
                            .foregroundColor(.white.opacity(0.8))
                            .font(.title2)
                            .bold()
                            .offset(y: 10)
                        Spacer()
                        if let image = model.image {
                            Image(uiImage: image)
                                .frame(width: 300, height: 300)
                            
                        } else {
                            Image("placeholderImage")
                                .resizable()
                                .frame(width: 300, height: 300)
                                .opacity(0.5)
                        }
                        Spacer()
                        HStack {
                                            Text("Intensity")
                                            Slider(value: $filterIntensity)
                                                .onChange(of: filterIntensity) { _ in applyProcessing() }
                                        }
                                        .padding(.vertical)
                        Text("ENTER YOUR PROMPT BELOW")
                            .foregroundColor(Color.black)
                            .font(.caption2.bold())
                        TextField("Enter your prompt", text: $prompt)
                                      .padding(7)
                                      .padding(.horizontal, 25)
                                      .background(Color(.systemGray6))
                                      .cornerRadius(8)
                                      .padding(.horizontal, 10)
                        Button{
                            Task {
                                isLoading = true
                                model.image = await viewModel.generateImage(from: prompt)
                                isLoading = false
                            }
                        }label: {
                            Text("Generate")
                            .foregroundColor(.white)
                            
                            .onAppear {
                                viewModel.setup()
                            }
                        }
                        .frame(width: 350  ,height: 45)
                        .background(.black)
                        .cornerRadius(25)
                        .padding(.vertical ,15)
                    }
                }
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                            Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                            Button("Edges") { setFilter(CIFilter.edges()) }
                            Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                            Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                            Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                            Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                            Button("Vignette") { setFilter(CIFilter.vignette()) }
                            Button("Cancel", role: .cancel) { }
                        }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                   // Button("Deleet") {
                    //    model.nillimage()
                   // }
                    Button("Filter") {
                        showingFilterSheet = true
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        let imageSaver = ImageSaver()
                        imageSaver.writeToPhotoAlbum(image: model.image!)
                    } label:{
                        Image(systemName: "square.and.arrow.down")
                                                    .font(.system(size: 20))
                                                    .aspectRatio( contentMode: .fit)
                                                    .frame(width: 25, height: 25)
                                                    .padding(10)
                    }
                    .cornerRadius(100)
                            }
                    }
            .navigationTitle("Image Generator Ai")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color("backgroundColor"))
        }
    }
    func loadImage() {
        guard let inputImage = model.image else { return }


            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    func applyProcessing() {
            let inputKeys = currentFilter.inputKeys

            if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
            if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
            if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }

            guard let outputImage = currentFilter.outputImage else { return }

            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                let uiImage = UIImage(cgImage: cgimg)
                model.image = uiImage
               
            }
        }
    func setFilter(_ filter: CIFilter) {
            currentFilter = filter
            loadImage()
        }
    class ImageSaver: NSObject {
        func writeToPhotoAlbum(image: UIImage) {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
        }
        @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            print("Save finished!")
        }
    }
}
