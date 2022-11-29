//
//  InviteView.swift
//  CryptoApp
//
//  Created by NikoS on 14.02.2022.
//

import SwiftUI

struct ProfileView: View {
    private let storage = SecureStorage()
    @State private var userEmail: String = ""
    @State var keyboardYOffset: CGFloat = 0
    @ObservedObject var userSettings = UserSettings()
    @ObservedObject var viewModel = SignUpViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 50) {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color.gray)
                    .clipShape(Circle())
                ScrollViewReader { (proxy: ScrollViewProxy) in
                    ScrollView {
                        VStack(spacing: 20) {
                            HStack {
                                Text("First Name")
                                    .font(.system(size: 20))
                                    .padding(.leading)
                                Spacer()
                                TextField(
                                    "Please enter here", text: $userSettings.username
                                )
                                .font(.system(size: 15))
                                .padding(.trailing)
                                .fixedSize()
                            }
                            .onTapGesture {
                                proxy.scrollTo(1, anchor: .center)
                            }
                            .id(1)
                            HStack {
                                Text("Second Name")
                                    .font(.system(size: 20))
                                    .padding(.leading)
                                Spacer()
                                
                                TextField(
                                    "Please enter here", text: $userSettings.secondname
                                )
                                .font(.system(size: 15))
                                .fixedSize()
                                .padding(.trailing)
                            }
                            .onTapGesture {
                                proxy.scrollTo(2, anchor: .center)
                            }
                            .id(2)
                            HStack() {
                                Text("User's e-mail")
                                    .font(.system(size: 20))
                                    .padding(.leading)
                                Spacer()
                                Text(try! storage.get(key: SecureStorage.Keys.email) ?? "")
                                    .font(.system(size: 15))
                                    .fixedSize()
                                    .padding(.trailing)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
