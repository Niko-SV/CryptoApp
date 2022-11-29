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
            Text("Create your Cryptex account")
                .font(.system(size: 30))
                .foregroundColor(.yellow)
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
                Text(viewModel.emailPrompt)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.caption)
                    .foregroundColor(.red)
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(50)
                Text(viewModel.passwordPrompt)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.caption)
                    .foregroundColor(.red)
                SecureField("Password", text: $viewModel.confirmPassword)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(50)
                Text(viewModel.confirmPasswordPrompt)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.caption)
                    .foregroundColor(.red)
                
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
                    
                    Text("Sign Up")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(50)
                    
                })
                    .padding()
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
