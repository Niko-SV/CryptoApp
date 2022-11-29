//
//  AuthView.swift
//  CryptoApp
//
//  Created by NikoS on 10.02.2022.
//

import SwiftUI
import Firebase

struct AuthView: View {
    
    @State private var viewModel = AuthViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            if authViewModel.signedIn {
                ContentView()
            } else {
                VStack(alignment: .center, spacing: 0.0) {
                    Text("Welcome to Cryptex")
                        .font(.system(size: 30))
                        .foregroundColor(.yellow)
                        .padding()
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                    VStack {
                        TextField("Email Address", text: $viewModel.email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(50)
                        Text(viewModel.emailError)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.caption)
                            .foregroundColor(.red)
                        SecureField("Password", text: $viewModel.password)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(50)
                        Text(viewModel.passwordError)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.caption)
                            .foregroundColor(.red)
                        
                        Button(action: {
                            guard !viewModel.email.isEmpty, !viewModel.password.isEmpty else {
                                return
                            }
                            authViewModel.signIn(email: viewModel.email, password: viewModel.password)
                        }, label: {
                            Text("Sign In")
                                .foregroundColor(Color.white)
                                .frame(width: 200, height: 50)
                                .background(Color.blue)
                                .cornerRadius(50)
                        })
                            .padding()
                        NavigationLink("Create Account", destination: SignUpView())
                            .padding()
                    }
                    .padding()
                    
                    Spacer()
                }
            }
        }.onAppear {
            authViewModel.signedIn = authViewModel.isSignedIn
        }
    }
}


struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}


