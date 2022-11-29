//
//  SignUpView.swift
//  CryptoApp
//
//  Created by NikoS on 10.02.2022.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    
    @ObservedObject var viewModel = SignUpViewModel()
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            topText
            ImageLogo()
            
            VStack {
                TextField("Email Address", text: $viewModel.email)
                    .modifier(TextFieldModifiers())
                AuthTextView(text: viewModel.emailPrompt)
                secureTextField(text: Constants.passwordText, bindingText: $viewModel.password)
                AuthTextView(text: viewModel.passwordPrompt)
                secureTextField(text: Constants.passwordText, bindingText: $viewModel.confirmPassword)
                AuthTextView(text: viewModel.confirmPasswordPrompt)
                Button(action: {
                    
                    guard !viewModel.email.isEmpty, !viewModel.password.isEmpty, viewModel.password == viewModel.confirmPassword, viewModel.isEmailValid(), viewModel.isPasswordValid(), viewModel.passwordsMatch() else {
                        return
                    }
                    do {
                        try SecureStorage().put(object: viewModel.password, for: SecureStorage.Keys.password)
                        try SecureStorage().put(object: viewModel.email, for: SecureStorage.Keys.email)
                    } catch {
                        print(error)
                    }
                    authViewModel.signUp(email: viewModel.email, password: viewModel.password)
                    
                }, label: {
                    SignInUpText(text: "Sign Up")
                })
                    .padding()
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
        }
    }
    
    private var topText: some View {
        Text("Create your Cryptex account")
            .font(.system(size: 30))
            .foregroundColor(.yellow)
    }
    
    private func secureTextField(text: String, bindingText: Binding<String>) -> some View {
        SecureField(text, text: bindingText)
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(50)
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
