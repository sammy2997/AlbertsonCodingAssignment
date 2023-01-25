//
//  ContentView.swift
//  AlbertsonCodingAssignment
//
//  Created by Samuel Adama on 1/25/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = CatViewModel()
    @State var fact: String = ""
    @State var image: UIImage = UIImage()
    @State var loading = false
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(Color.gray)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                if loading {
                    
                    FactImageView(fact: $fact, image: $image)
                    
                } else {
                    ProgressView()
                        .frame(width: 500, height: 500)
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(LinearGradient(colors: [Color.gray, Color.clear], startPoint: .topLeading, endPoint: .bottomTrailing))
            .edgesIgnoringSafeArea(.bottom)
            .edgesIgnoringSafeArea(.top)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Image(systemName: "sparkles")
                        Text("Cat Power")
                            .fontWeight(.heavy)
                            .font(.largeTitle)
                    }
                }
            }

            .onTapGesture {
                getData()
            }
            .onAppear() {
                getData()
            }
        }
    }
    
    func getData() {
        self.loading = false
        
        let group = DispatchGroup()
        
        // enter for first API
        group.enter()
        
        // Call first API
        viewModel.loadFacts { fact in
            self.fact = fact.data.first ?? ""
            group.leave()
        }
        
        group.enter()
        
        viewModel.downloadImage { image in
            self.image = image
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.loading = true
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

