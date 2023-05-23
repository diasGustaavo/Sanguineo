//
//  RegisterView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 19/05/23.
//

import SwiftUI
import Introspect
import AVFoundation

struct RegisterView: View {
    @State private var selectedTab = 0
    @State var name = ""
    @State private var isCheckedForm = false
    @State private var isCheckedEmail = false
    @State private var isCameraAuthorized = false
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<3) { index in // Adjust the range for number of tabs
                    Rectangle()
                        .fill(selectedTab == index ? .accentColor : Color.gray)
                        .frame(width: 80, height: 5)
                        .cornerRadius(3)
                        .onTapGesture {
                            selectedTab = index
                        }
                }
            }
            .padding()
            
            TabView(selection: $selectedTab) {
                PersonalInfo(name: $name, isChecked: $isCheckedForm, selectedTab: $selectedTab)
                    .tag(0)
                ConfirmationCodeView(selectedTab: $selectedTab, isChecked: $isCheckedEmail)
                    .tag(1)
                DocumentRequestView()
                    .tag(2)
                // Add more tabs as needed
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide default tab indicators
        }
        .onAppear {
            requestCameraPermission()
        }
    }
    
    private func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                isCameraAuthorized = granted
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

struct PersonalInfo: View {
    @Binding var name: String
    @Binding var isChecked: Bool
    @Binding var selectedTab: Int
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Preencha suas informações pessoais")
                    .multilineTextAlignment(.leading)
                    .font(.custom("Nunito-SemiBold", size: 24))
                
                Spacer()
                
                // TEXTFIELDS
                Group {
                    CustomTextField(content: $name, logo: "person", placeholder: "Nome e sobrenome")
                    
                    Spacer()
                        .frame(height: 20)
                    
                    CustomTextField(content: $name, placeholder: "E-mail")
                    
                    Spacer()
                        .frame(height: 20)
                    
                    CustomTextField(content: $name, logo: "lock", placeholder: "Senha")
                    
                    Spacer()
                        .frame(height: 20)
                    
                    CustomTextField(content: $name, logo: "lock", placeholder: "Senha")
                    
                    Spacer()
                        .frame(height: 20)
                    
                    CustomTextField(content: $name, logo: "iphone", placeholder: "Número do celular")
                }
                
                Spacer()
                
                HStack {
                    Button {
                        isChecked.toggle()
                    } label: {
                        Image(systemName: isChecked ? "checkmark.square" : "square")
                            .font(.system(size: 13))
                            .foregroundColor(.accentColor)
                    }
                    
                    Text("Ao preencher o formulário acima você concorda com os nossos termos de uso e nossa politica de privacidade. ")
                        .font(.custom("Nunito-Light", size: 14))
                    
                    Spacer()
                }
                
                
                Spacer()
                
                HStack {
                    Button {
                        // some action
                    } label: {
                        Text("Voltar")
                            .bold()
                            .frame(height: 56)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color(UIColor(named: "AccentColor")!))
                            .overlay(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                            .font(.custom("Nunito-SemiBold", size: 20))
                    }
                    
                    Spacer()
                        .frame(width: 15)
                    
                    Button {
                        withAnimation {
                            selectedTab += 1
                        }
                    } label: {
                        Text("Próximo")
                            .bold()
                            .frame(height: 56)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color(UIColor(named: "AccentColor")!))
                            .cornerRadius(7)
                            .font(.custom("Nunito-SemiBold", size: 20))
                    }
                }

                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct ConfirmationCodeView: View {
    @State private var confirmationCode = Array(repeating: "", count: 4)
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var currentFocus: Int? = 0
    @Binding var selectedTab: Int
    @Binding var isChecked: Bool
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Suas principais informações já foram coletadas.")
                    .multilineTextAlignment(.leading)
                    .font(.custom("Nunito-SemiBold", size: 24))
                
                Text("Um código foi enviado ao seu e-mail, use-o para autenticar sua conta.")
                    .multilineTextAlignment(.leading)
                    .font(.custom("Nunito-SemiBold", size: 24))
                
                Spacer()
                    .frame(height: 25)
                
                HStack {
                    Spacer()
                    
                    ForEach(0..<4) { index in
                        CodeInputField(text: $confirmationCode[index], index: index, confirmationCode: $confirmationCode, currentFocus: $currentFocus)
                    }
                    
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 25)
                
                HStack {
                    Button {
                        // some action
                    } label: {
                        Text("Voltar")
                            .bold()
                            .frame(height: 56)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color(UIColor(named: "AccentColor")!))
                            .overlay(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                            .font(.custom("Nunito-SemiBold", size: 20))
                    }
                    
                    Button(action: {
                        DispatchQueue.main.async {
                            let code = confirmationCode.joined()
                            if code.count < 4 {
                                alertMessage = "Por favor digite o código completo enviado para o seu email"
                                showAlert = true
                            } else if !code.allSatisfy({ "0123456789".contains($0) }) {  // check if all characters are numbers
                                alertMessage = "Por favor, use apenas números no código de confirmação"
                                showAlert = true
                            } else {
                                self.currentFocus = 5
                                withAnimation {
                                    selectedTab += 1
                                }
                            }
                        }
                    }) {
                        Text("Próximo")
                            .bold()
                            .frame(height: 56)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .cornerRadius(7)
                            .font(.custom("Nunito-SemiBold", size: 20))
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Código inválido"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                
                Spacer()
                    .frame(height: 25)
                
                HStack() {
                    Spacer()
                    
                    Button {
                        // some action
                    } label: {
                        Text("Reenviar Codigo ")
                            .font(.custom("Nunito-Light", size: 14))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                }
                
                HStack() {
                    Spacer()
                    
                    Button {
                        // some action
                    } label: {
                        Text("Ajuda")
                            .font(.custom("Nunito-Light", size: 14))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct CodeInputField: View {
    @Binding var text: String
    var index: Int
    @Binding var confirmationCode: [String]
    @Binding var currentFocus: Int?
    
    var body: some View {
        TextField("", text: Binding(
            get: { self.text },
            set: { newValue in
                self.text = newValue
                if newValue.count > 0 && self.index < 3 {
                    self.currentFocus = self.index + 1
                }
            })
        )
        .keyboardType(.numberPad)
        .onChange(of: text) { newValue in
            if newValue.count > 1 {
                text = String(newValue.last ?? " ")
            }
        }
        .multilineTextAlignment(.center)
        .frame(width: 50, height: 80) // Increase the height value here
        .font(Font.system(size: 24))
        .padding(.horizontal)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        )
        .textContentType(.oneTimeCode)
        .id(index)  // Add id
        .introspectTextField { textField in
            DispatchQueue.main.async {
                if self.index == self.currentFocus {
                    textField.becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                }
            }
        }
    }
}

struct DocumentRequestView: View {
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage? = UIImage(named: "carteiraIdentidade")

    var body: some View {
        VStack(alignment: .leading) {
            Text("Quase lá, agora precisamos do seu RG ou CNH")
                .multilineTextAlignment(.leading)
                .font(.custom("Nunito-SemiBold", size: 24))
            
            Spacer()
            
            HStack {
                Spacer()

                Image(uiImage: selectedImage!)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .frame(height: UIScreen.main.bounds.height * 0.55)
                    .overlay(Button(action: {
                        self.isShowingImagePicker = true
                    }) {
                        Image(systemName: "camera")
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(10)
                    })
                
                Spacer()
            }
            
            Spacer()
            
            Text("Ambiente bem iluminado e certifique-se da sua câmera estar limpa")
                .font(.custom("Nunito-Light", size: 14))
                .foregroundColor(.red)
            
            Spacer()
            
            HStack {
                Button {
                    // some action
                } label: {
                    Text("Voltar")
                        .bold()
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color(UIColor(named: "AccentColor")!))
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                        .font(.custom("Nunito-SemiBold", size: 20))
                }
                
                Button(action: {
                    // some action
                }) {
                    Text("Enviar")
                        .bold()
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(7)
                        .font(.custom("Nunito-SemiBold", size: 20))
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $selectedImage, sourceType: .camera)
        }
    }
    
    func loadImage() {
        guard let _ = selectedImage else { return }
        // do something with the selected image
    }
}

