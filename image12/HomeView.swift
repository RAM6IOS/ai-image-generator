//
//  HomeView.swift
//  image12
//
//  Created by Bouchedoub Ramzi on 2/3/2023.
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct HomeView: View {
    @StateObject private var viewModel = ImageGeneratorViewModel()
    @State var prompt: String = ""
    @State var isLoading: Bool = false
    @StateObject var filter = FilterViewModel()
    var body: some View {
            NavigationView{
                ZStack{
                    Color.black
                       .ignoresSafeArea()
                VStack{
                    if isLoading {
                        ProgressView()
                            .tint(.gray)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("backgroundColor"))
                    } else {
                        VStack {
                            if let image = filter.image {
                                GeometryReader { (proxy: GeometryProxy) in
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: proxy.size.width  ,height:400)
                                        .cornerRadius(10)
                                }
                            } else {
                                Image("placeholderImage")
                                    .resizable()
                                    .frame(width: 300, height: 300)
                                    .opacity(0.5)
                            }
                        }
                    }
                    VStack{
                        if let image = filter.image{
                            VStack{
                                ShareLink(item: Image(uiImage: image), preview: SharePreview("Image", image:Image(uiImage: image)))
                                    .foregroundColor(Color.black)
                            }
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(10)
                            HStack {
                                Text(filter.showView)
                                    .foregroundColor(.white)
                                Slider(value: $filter.filterIntensity)
                                    .onChange(of: filter.filterIntensity) { _ in filter.applyProcessing() }
                            }
                            .padding(.vertical)
                        }
                        Text("ENTER YOUR PROMPT BELOW")
                            .foregroundColor(Color.white)
                            .font(.caption2.bold())
                        TextField("Enter your prompt", text: $prompt)
                            .padding(7)
                            .padding(.horizontal, 25)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
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
                        .background(Color.newColor)
                        .cornerRadius(10)
                        .padding(.vertical ,15)
                    }
                    .padding(.top ,10)
                }
                .sheet(isPresented:$filter.showshit ){
                    AboutView()
                    
                }
                .confirmationDialog("Select a filter", isPresented: $filter.showingFilterSheet) {
                    Button("Edges") { filter.setFilter(CIFilter.edges())
                            filter.showView = "Edges"
                    }
                    Button("Gaussian Blur") {filter.setFilter(CIFilter.gaussianBlur())
                        filter.showView = "Gaussian Blur"
                    }
                    Button("Pixellate") { filter.setFilter(CIFilter.pixellate())
                        filter.showView = "Pixellate"
                    }
                    Button("Sepia Tone") { filter.setFilter(CIFilter.sepiaTone())
                        filter.showView = "Sepia Tone"
                    }
                    Button("Unsharp Mask") { filter.setFilter(CIFilter.unsharpMask())
                        filter.showView = "Unsharp Mask"
                    }
                    Button("Vignette") { filter.setFilter(CIFilter.vignette())
                        filter.showView = "Vignette"
                    }
                    Button("Crystallize") { filter.setFilter(CIFilter.crystallize())
                        filter.showView = "Crystallize"
                    }
                    Button("Cancel", role: .cancel) { }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Menu("Menu"){
                            Button{
                                filter.showshit.toggle()
                            } label: {
                                Text("About")
                            }
                            Link("Privacy Policy", destination: URL(string: "https://www.app-privacy-policy.com/live.php?token=OAsUAHyVsmgZBGvJNq685DYq2d91JQbt")!)
                            Button("Filter") {
                                filter.showingFilterSheet = true
                            }
                            Button("Deleet") {
                                filter.nillimage()
                            }
                        }
                        .foregroundColor(.white)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button{
                            filter.writeToPhotoAlbum(image: filter.image!)
                        } label:{
                            Image(systemName: "square.and.arrow.down")
                                .font(.system(size: 20))
                                .aspectRatio( contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
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
    }

