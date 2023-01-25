//
//  FactImageView.swift
//  AlbertsonCodingAssignment
//
//  Created by Samuel Adama on 1/25/23.
//

import SwiftUI
import SwiftUI

struct FactImageView: View {
    @Binding var fact: String
    @Binding var image: UIImage
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(uiImage: image)
                .resizable()
                .frame(height: 500)
                .scaledToFit()
                .cornerRadius(20)
            
            Text("Cat Fact:")
                .fontWeight(.heavy)
                .font(.headline)
                .padding(.top, 10)
            
            Text(fact)
                .bold()
                .italic()
                .padding([.bottom, .leading, .trailing], 10)
        }
        .padding(10)
        .padding([.top, .bottom], 75)
    }
}

struct FactImageView_Previews: PreviewProvider {
    @State static var fact = ""
    @State static var image = UIImage()
    
    static var previews: some View {
        FactImageView(fact: $fact, image: $image)
    }
}

