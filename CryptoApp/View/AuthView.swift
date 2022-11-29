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
                    welcomeText
                    ImageLogo()
                    VStack {
                        TextField("Email Address", text: $viewModel.email)
                            .modifier(TextFieldModifiers())
                        AuthTextView(text: viewModel.emailError)
                        SecureField("Password", text: $viewModel.password)
                            .modifier(TextFieldModifiers())
                        AuthTextView(text: viewModel.passwordError)
                        Button(action: {
                            guard !viewModel.email.isEmpty, !viewModel.password.isEmpty else {
                                return
                            }
                            authViewModel.signIn(email: viewModel.email, password: viewModel.password)
                        }, label: {
                            SignInUpText(text: "Sign In")
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
    
    private var welcomeText: some View {
        Text("Welcome to Cryptex")
            .font(.system(size: 30))
            .foregroundColor(.yellow)
            .padding()
    }
    
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}


