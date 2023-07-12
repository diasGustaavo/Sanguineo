//
//  AppointmentsViewModel.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 07/07/23.
//

import FirebaseFirestore
import UIKit

class AppointmentsViewModel: ObservableObject {
    @Published var appointmentDate: Date
    @Published var associatedRequestId: String
    
    @Published var appointments: [Appointment]
    @Published var appointment: Appointment
    
    @Published var name: String = ""
    @Published var image = UIImage(named: "3davatar2")!
    @Published var nationality = "Brasileira"
    @Published var bloodtype = "O+"
    @Published var description = "bla bla bla"
    
    @Published var selectedDate: Date = Date()
    @Published var selectedTime: Date  = Date()
    
    @Published var isLoading: Bool
    @Published var isSingleDonationLoading: Bool
    
    let calendar = Calendar.current
    
    init() {
        self.appointmentDate = Date()
        self.associatedRequestId = ""
        
        self.appointments = [Appointment]()
        self.appointment = Appointment(appointmentDate: Date(), requestId: "", authorUID: "")
        
        self.isLoading = true
        self.isSingleDonationLoading = true
    }
    
    func saveAppointment(authorUID: String, requestUID: String = "", appointmentUID: String = "") {
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: selectedTime)

        let combinedComponents = DateComponents(year: dateComponents.year, month: dateComponents.month, day: dateComponents.day, hour: timeComponents.hour, minute: timeComponents.minute, second: timeComponents.second)
        
        print("SAVING WITH \(combinedComponents)")
        
        if let combinedDate = calendar.date(from: combinedComponents) {
            let appointment = Appointment(appointmentDate: combinedDate, requestId: requestUID, authorUID: authorUID)
            
            do {
                var appointmentDocument = try Firestore.Encoder().encode(appointment)
                // Remove the ID field from the document, because Firestore will automatically assign it an ID
                appointmentDocument["id"] = nil
                
                let db = Firestore.firestore()
                
                if appointmentUID.isEmpty {
                    // If appUID is empty, add a new document
                    db.collection("appointments").addDocument(data: appointmentDocument) { error in
                        if let error = error {
                            print("DEBUG: Error adding appointment: \(error)")
                        } else {
                            print("DEBUG: Appointment successfully added!")
                        }
                    }
                } else {
                    // If appUID is not empty, update the existing document with the appUID
                    db.collection("appointments").document(appointmentUID).setData(appointmentDocument) { error in
                        if let error = error {
                            print("DEBUG: Error updating appointment: \(error)")
                        } else {
                            print("DEBUG: Appointment successfully updated!")
                        }
                    }
                }
            } catch {
                print("DEBUG: Error encoding appointment: \(error)")
            }
        }
    }
    
    func fetchAppointments(for authorUID: String) {
        isLoading = true
        let db = Firestore.firestore()
        db.collection("appointments").whereField("authorUID", isEqualTo: authorUID).getDocuments { querySnapshot, error in
            if let error = error {
                print("DEBUG: Error getting appointments: \(error)")
                self.isLoading = false
            } else if let querySnapshot = querySnapshot {
                self.isLoading = false
                self.appointments = querySnapshot.documents.compactMap { document -> Appointment? in
                    var appointment = try? document.data(as: Appointment.self)
                    appointment?.id = document.documentID
                    return appointment
                }
            }
        }
    }
    
    func fetchAppointment(with appointmentUID: String) {
        isSingleDonationLoading = true
        let db = Firestore.firestore()
        
        db.collection("appointments").document(appointmentUID).getDocument { document, error in
            if let error = error {
                print("DEBUG: Error getting appointment: \(error)")
                
                self.isSingleDonationLoading = false
            } else if let document = document, document.exists, let appointment = try? document.data(as: Appointment.self) {
                self.appointment = appointment
                self.selectedDate = appointment.appointmentDate
                self.selectedTime = appointment.appointmentDate
                
                self.isSingleDonationLoading = false
            } else {
                print("DEBUG: Appointment does not exist")
                
                self.isSingleDonationLoading = false
            }
        }
    }
}
