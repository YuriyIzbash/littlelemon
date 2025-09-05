//
//  Menu.swift
//  littlelemon
//
//  Created by yuriy on 5. 9. 25.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Little Lemon 🍋")
                .font(.largeTitle)
                .bold()
            
            Text("Chicago")
                .font(.title2)
            
            Text("The best Mediterranean food in town, served fresh daily.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            List {
                // Menu items will be added later
            }
        }
        .padding()
    }
}

#Preview {
    Menu()
}
