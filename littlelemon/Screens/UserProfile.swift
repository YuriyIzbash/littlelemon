//
//  UserProfile.swift
//  littlelemon
//
//  Created by yuriy on 5. 9. 25.
//

import SwiftUI

struct UserProfile: View {
    let firstName = UserDefaults.standard.string(forKey: kFirstName) ?? "N/A"
    let lastName  = UserDefaults.standard.string(forKey: kLastName) ?? "N/A"
    let email     = UserDefaults.standard.string(forKey: kEmail) ?? "N/A"
    
    @Environment(\.presentationMode) var presentation

    var body: some View {
        VStack(spacing: 20) {
            Text("Personal information")
                .font(.title)
                .padding(.top)
            
            Image("profile-image-placeholder")
                .resizable()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .shadow(radius: 5)
                .padding()
            
            Text("First name: \(firstName)")
            Text("Last name: \(lastName)")
            Text("Email: \(email)")
            
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    UserProfile()
}
