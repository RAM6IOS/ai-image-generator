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
    @State var isLoading: Bool = false
    @StateObject var model = DrawingViewModel()
    @StateObject var filter = FilterViewModel()
    @State var showView = "Crystallize"
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
                        if let image = filter.image {
                            Image(uiImage: image)
                                .frame(width: 300, height: 300)
                            
                        } else {
                            Image("placeholderImage")
                                .resizable()
                                .frame(width: 300, height: 300)
                                .opacity(0.5)
                        }
                        Spacer()
                        Button{
                            filter.lodimage2()
                        }label: {
                            Text("lodaImage")
                                .foregroundColor(Color.red)
                                .background(.black)
                                .frame(width: 100, height: 100)
                        }
                        HStack {
                                            Text(showView)
                            Slider(value: $filter.filterIntensity)
                                .onChange(of: filter.filterIntensity) { _ in filter.applyProcessing() }
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
                                    filter.image = await viewModel.generateImage(from: prompt)
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
            .confirmationDialog("Select a filter", isPresented: $filter.showingFilterSheet) {
              
                Button("Edges") { filter.setFilter(CIFilter.edges())
                    showView = "Edges"
                    filter.filterIntensity = 0.0
                }
                Button("Gaussian Blur") {filter.setFilter(CIFilter.gaussianBlur())
                    showView = "Gaussian Blur"
                    filter.filterIntensity = 0.0
                }
                Button("Pixellate") { filter.setFilter(CIFilter.pixellate())
                    showView = "Pixellate"
                    filter.filterIntensity = 0.0
                }
                Button("Sepia Tone") { filter.setFilter(CIFilter.sepiaTone())
                    showView = "Sepia Tone"
                    filter.filterIntensity = 0.0
                }
                Button("Unsharp Mask") { filter.setFilter(CIFilter.unsharpMask())
                    showView = "Unsharp Mask"
                        filter.filterIntensity = 0.0
                }
                Button("Vignette") { filter.setFilter(CIFilter.vignette())
                    showView = "Vignette"
                    filter.filterIntensity = 0.0
                }
                Button("Crystallize") { filter.setFilter(CIFilter.crystallize())
                    showView = "Crystallize"
                    filter.filterIntensity = 0.0
                }
                            Button("Cancel", role: .cancel) { }
                        }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Deleet") {
                    filter.nillimage()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Filter") {
                        filter.showingFilterSheet = true
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                     filter.writeToPhotoAlbum(image: filter.image!)
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
}
