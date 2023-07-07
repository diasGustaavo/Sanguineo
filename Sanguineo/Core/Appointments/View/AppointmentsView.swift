//
//  AppointmentsView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 30/05/23.
//

import SwiftUI

struct AppointmentsView: View {
    @ObservedObject var navigationBarViewModel: NavigationBarViewModel
    
    @State private var showingDonationView = false
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Última doação e tempo para doar novamente")
                        .font(.custom("Nunito-SemiBold", size: 22))
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
                .padding()
                
                HStack(content: {
                    VStack(alignment: .leading) {
                        Text("Sua ultima doação foi no dia 24/07/2022.")
                            .font(.custom("Nunito-Light", size: 16))
                            .multilineTextAlignment(.leading)
                        
                        Text("Você está apto para doar novamente!")
                            .font(.custom("Nunito-SemiBold", size: 16))
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    
                    Spacer()
                })
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.accentColor, lineWidth: 0.8)
                )
                .padding(.horizontal)
                
                HStack {
                    Text("Seus Agendamentos")
                        .font(.custom("Nunito-SemiBold", size: 22))
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
                .padding()
                
                Button {
                    showingDonationView.toggle()
                } label: {
                    HStack {
                        Image(uiImage: UIImage(named: "3d_avatar_3")!)
                            .resizable()
                            .frame(width: UIScreen.screenWidth * 0.2, height: UIScreen.screenWidth * 0.2)
                        
                        Spacer()
                        
                        Text("Principais informações do agendamento")
                            .font(.custom("Nunito-Light", size: 16))
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.accentColor, lineWidth: 0.8)
                    )
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                .sheet(isPresented: $showingDonationView) {
                    DonateView(navigationBarViewModel: navigationBarViewModel)
                }
                
                Button {
                    showingDonationView.toggle()
                } label: {
                    HStack {
                        Image(uiImage: UIImage(named: "3d_avatar_7")!)
                            .resizable()
                            .frame(width: UIScreen.screenWidth * 0.2, height: UIScreen.screenWidth * 0.2)
                        
                        Spacer()
                        
                        Text("Principais informações do agendamento")
                            .font(.custom("Nunito-Light", size: 16))
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.accentColor, lineWidth: 0.8)
                    )
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                .sheet(isPresented: $showingDonationView) {
                    DonateView(navigationBarViewModel: navigationBarViewModel)
                }
                
                Spacer()
            }
        }
    }
}

struct AppointmentsView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentsView(navigationBarViewModel: NavigationBarViewModel())
    }
}
