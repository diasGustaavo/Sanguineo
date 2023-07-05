//
//  NotificationsView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 15/06/23.
//

import SwiftUI

struct NotificationsView: View {
    @Environment(\.presentationMode) var presentationMode
    @GestureState private var dragOffset = CGSize.zero
    
    @State var notifications = false
    @State var email = false
    @State var sms = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.custom("Nunito-Semibold", size: 25))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                            .padding(.trailing)
                    }
                    
                    Spacer()
                    
                    Text("Gerenciar notificações")
                        .font(.custom("Nunito-Bold", size: 20))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Spacer().frame(width: 40)
                }
                .padding()
                .padding(.horizontal, 6)
                
                ScrollView {
                    HStack {
                        Text("Como você quer receber novidades e lembretes do Sanguineo")
                            .font(.custom("Nunito-Regular", size: 18))
                        
                        Spacer()
                        
                        Spacer().frame(width: 50)
                    }
                    .padding()
                    
                    CustomToggleCell(leftSymbol: "bell", toggleText: "Gerenciar notificações", isOn: $notifications)
                    
                    CustomToggleCell(leftSymbol: "paintpalette", toggleText: "Tema", isOn: $email)
                    
                    CustomToggleCell(leftSymbol: "info.circle", toggleText: "Sobre esta versão", isOn: $sms)
                }
            }
        }
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
        
            if(value.startLocation.x < 20 && value.translation.width > 100) {
                self.presentationMode.wrappedValue.dismiss()
            }
            
        }))
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
