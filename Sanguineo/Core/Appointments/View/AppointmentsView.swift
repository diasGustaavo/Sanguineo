//
//  AppointmentsView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 30/05/23.
//

import SwiftUI
import SwiftUIPullToRefresh

struct AppointmentsView: View {
    @EnvironmentObject var appointmentsViewModel: AppointmentsViewModel
    @EnvironmentObject var initialLogViewModel: InitialLogViewModel
    
    @ObservedObject var navigationBarViewModel: NavigationBarViewModel
    
    @State private var showingDonationView = false
    
    var body: some View {
        RefreshableScrollView(onRefresh: { done in
            if let currentUserUID = initialLogViewModel.currentUser?.uid {
                appointmentsViewModel.fetchAppointmentsAndDo(for: currentUserUID) {
                    done()
                }
            } else {
                done()
            }
        },
                              progress: { state in
            if state == .waiting {
                // empty view
            } else {
                Spinner(lineWidth: 5, height: 32, width: 32)
            }
        }) {
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
                
                if !appointmentsViewModel.isLoading {
                    if appointmentsViewModel.appointments.isEmpty {
                        HStack(content: {
                            VStack(alignment: .leading) {
                                Text("Você não tem nenhuma agendamento.")
                                    .font(.custom("Nunito-Light", size: 16))
                                    .multilineTextAlignment(.leading)
                                
                                Text("Efetue um agendamento na aba início.")
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
                    } else {
                        ForEach(appointmentsViewModel.appointments, id: \.self) { appointment in
                            Button {
                                if let appointmentId = appointment.id {
                                    navigationBarViewModel.reqUID = appointmentId
                                    showingDonationView.toggle()
                                }
                            } label: {
                                HStack {
                                    Image(uiImage: appointmentsViewModel.profileImages[appointment.authorUID] ?? UIImage(named: "3d_avatar_7")!)
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                    
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
                            .sheet(isPresented: $showingDonationView, onDismiss: {
                                self.navigationBarViewModel.reqUID = ""
                            }) {
                                DonateView(navigationBarViewModel: navigationBarViewModel)
                            }
                        }
                    }
                } else {
                    VStack {
                        Spacer()
                            .frame(height: 40)
                        
                        Spinner(lineWidth: 5, height: 32, width: 32)
                        
                        Spacer()
                            .frame(height: 20)
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct AppointmentsView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentsView(navigationBarViewModel: NavigationBarViewModel())
            .environmentObject(InitialLogViewModel())
            .environmentObject(AppointmentsViewModel())
    }
}
