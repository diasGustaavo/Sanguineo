//
//  DonateView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 02/06/23.
//

import SwiftUI

struct DonateView: View {
    @State var selectedDate: Date = Date()
    @State private var selectedTime = Date()
    
    @ObservedObject var navigationBarViewModel: NavigationBarViewModel
    @EnvironmentObject var appointmentsViewModel: AppointmentsViewModel
    @EnvironmentObject var initialLogViewModel: InitialLogViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    let earliestTime: Date
    let latestTime: Date
    
    init(navigationBarViewModel: NavigationBarViewModel) {
        self.navigationBarViewModel = navigationBarViewModel
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        var components = DateComponents()
        components.hour = 8
        earliestTime = calendar.date(from: components)!
        
        components.hour = 18
        latestTime = calendar.date(from: components)!
        
        _selectedTime = State(initialValue: earliestTime)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                // HEADER
                HStack {
                    Button {
                        withAnimation {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.custom("Nunito-Semibold", size: 25))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                            .padding(.trailing)
                    }
                    
                    Spacer()
                    
                    Text("Rua Empresario Manoel...")
                        .font(.custom("Nunito-Light", size: 16))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Spacer().frame(width: 30)
                }
                .padding(.horizontal, 16)
                .padding(.top)
                
                HStack {
                    Image(uiImage: appointmentsViewModel.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                    
                    VStack(alignment: .leading) {
                        Text(appointmentsViewModel.name)
                            .lineLimit(1)
                            .font(.custom("Nunito-SemiBold", size: 20))
                    }
                    .padding(6)
                    
                    Spacer()
                }
                .padding(.all)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Principais informações do solicitante:")
                            .lineLimit(1)
                            .font(.custom("Nunito-Light", size: 17))
                        
                        Text("Nacionalidade: \(appointmentsViewModel.nationality) / Sangue: \(appointmentsViewModel.bloodtype)")
                            .lineLimit(1)
                            .font(.custom("Nunito-Light", size: 15))
                        
                        Text("\(appointmentsViewModel.description)")
                            .lineLimit(1)
                            .font(.custom("Nunito-Light", size: 15))
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                HStack {
                    Text("Agendar a doação")
                        .font(.custom("Nunito-SemiBold", size: 20))
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, 1)
                
                HStack {
                    Text("Escolha uma data e confirme um horário")
                        .font(.custom("Nunito-Light", size: 14))
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                DatePicker("Selecionar Data", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .padding(.horizontal, 8)
                
                DatePicker("Selecionar Hora", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .onChange(of: selectedTime) { newDate in
                        let calendar = Calendar.current
                        let hour = calendar.component(.hour, from: newDate)
                        if hour < 8 {
                            selectedTime = calendar.date(bySettingHour: 8, minute: 0, second: 0, of: newDate) ?? newDate
                        } else if hour > 18 {
                            selectedTime = calendar.date(bySettingHour: 18, minute: 0, second: 0, of: newDate) ?? newDate
                        }
                    }
                    .datePickerStyle(CompactDatePickerStyle())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
                
                Button {
                    if let currentUserUID = initialLogViewModel.currentUser?.uid {
                        appointmentsViewModel.saveAppointment(authorUID: currentUserUID, requestUID: navigationBarViewModel.reqUID)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Text("Confirmar Agendamento")
                        .font(.custom("Nunito-Regular", size: 22))
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color(UIColor(named: "AccentColor")!))
                        .cornerRadius(7)
                        .padding()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct DonateView_Previews: PreviewProvider {
    static let image = UIImage(named: "3d_avatar_28")!
    static let name = "Luciano Araujo"
    static let bloodtype = "O-"
    static let age: Int? = 22
    static let description = "Tratamento medico / Cirurgia"
    
    static var previews: some View {
        DonateView(navigationBarViewModel: NavigationBarViewModel())
    }
}
