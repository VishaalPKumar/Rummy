//
//  FloatingButton.swift
//  Rummy
//
//  Created by Vishaal Kumar on 8/15/24.
//

import SwiftUI

struct FloatingButton: View {
    
    var systemImageName: String
    var backgroundColor: Color = Color.secondary
    var foregroundColor: Color = Color.white
    var width: CGFloat = 60
    var height: CGFloat = 60
    var imageScale: Image.Scale = .large
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.thickMaterial)
                
            
            Image(systemName: systemImageName)
                .imageScale(imageScale)
                .foregroundColor(.secondary)
        }
        .frame(width: width, height: height)
    }
}

#Preview {
    FloatingButton(systemImageName: "list.clipboard")
}
