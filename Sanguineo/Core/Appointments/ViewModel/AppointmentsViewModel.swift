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
    
    @Published var name: String = ""
    @Published var image = UIImage(named: "3davatar2")!
    @Published var nationality = "Brasileira"
    @Published var bloodtype = "O+"
    @Published var description = "bla bla bla"
    
    @Published var isLoading: Bool
    
    init() {
        self.appointmentDate = Date()
        self.associatedRequestId = ""
        
        self.appointments = [Appointment]()
        
        self.isLoading = true
    }
    
    func saveAppointment(authorUID: String, requestUID: String = "") {
        let appointment = Appointment(id: nil, appointmentDate: appointmentDate, requestId: requestUID, authorUID: authorUID)
        
        do {
            var appointmentDocument = try Firestore.Encoder().encode(appointment)
            // Remove the ID field from the document, because Firestore will automatically assign it an ID
            appointmentDocument["id"] = nil
            
            let db = Firestore.firestore()
            
            if requestUID.isEmpty {
                // If appUID is empty, add a new document
                db.collection("appointments").addDocument(data: appointmentDocument) { error in
                    if let error = error {
                        print("DEBUG: Error adding appointment: \(error)")
                    } else {
                        print("DEBUG: Appointment successfully added!")
//                        self.resetFields()
                    }
                }
            } else {
                // If appUID is not empty, update the existing document with the appUID
                db.collection("appointments").document(requestUID).setData(appointmentDocument) { error in
                    if let error = error {
                        print("DEBUG: Error updating appointment: \(error)")
                    } else {
                        print("DEBUG: Appointment successfully updated!")
//                        self.resetFields()
                    }
                }
            }
        } catch {
            print("DEBUG: Error encoding appointment: \(error)")
        }
    }
    
    func fetchAppointments(for authorUID: String) {
        isLoading = true
        let db = Firestore.firestore()
        db.collection("appointments").whereField("authorUID", isEqualTo: authorUID).getDocuments { querySnapshot, error in
            if let error = error {
                print("DEBUG: Error getting appointments: \(error)")
            } else if let querySnapshot = querySnapshot {
                self.appointments = querySnapshot.documents.compactMap { document -> Appointment? in
                    var appointment = try? document.data(as: Appointment.self)
                    appointment?.id = document.documentID
                    self.isLoading = false
                    return appointment
                }
            }
        }
    }
}
