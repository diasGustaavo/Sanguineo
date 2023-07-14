//
//  AppointmentsViewModel.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 07/07/23.
//

import FirebaseFirestore
import UIKit
import FirebaseStorage

class AppointmentsViewModel: ObservableObject {
    @Published var appointmentDate: Date
    @Published var associatedRequestId: String
    
    @Published var appointments: [Appointment]
    @Published var appointment: Appointment
    
    var closestPastAppointment: Appointment? {
        let now = Date()
        return appointments.filter { $0.appointmentDate < now }
            .max(by: { $0.appointmentDate < $1.appointmentDate })
    }
    
    var canDonateAgain: Bool {
        guard let lastAppointment = closestPastAppointment else { return true }  // if no past appointment found, the user can donate
        let now = Date()
        let ninetyDaysAgo = Calendar.current.date(byAdding: .day, value: -90, to: now)!
        return lastAppointment.appointmentDate <= ninetyDaysAgo  // user can donate again if the last appointment is more than 90 days ago
    }
    
    @Published var name: String = ""
    @Published var image = UIImage(named: "3davatar2")!
    @Published var nationality = "Brasileira"
    @Published var bloodtype = "O+"
    @Published var description = "bla bla bla"
    
    @Published var profileImages: [String: UIImage] = [:]
    
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
                        }
                    }
                } else {
                    // If appUID is not empty, update the existing document with the appUID
                    db.collection("appointments").document(appointmentUID).setData(appointmentDocument) { error in
                        if let error = error {
                            print("DEBUG: Error updating appointment: \(error)")
                        }
                    }
                }
            } catch {
                print("DEBUG: Error encoding appointment: \(error)")
            }
        }
    }
    
    func fetchProfileImages(for authorUIDs: [String]) {
        let dispatchGroup = DispatchGroup()
        
        for authorUID in authorUIDs {
            dispatchGroup.enter()
            
            let imageName = authorUID + ".jpg"
            let imagePath = "profileImages/\(imageName)"
            let storage = Storage.storage().reference()
            storage.child(imagePath).getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print("Error fetching profile image: \(error)")
                } else if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.profileImages[authorUID] = image
                    }
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.isLoading = false
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
                self.appointments = querySnapshot.documents.compactMap { document -> Appointment? in
                    var appointment = try? document.data(as: Appointment.self)
                    appointment?.id = document.documentID
                    return appointment
                }
                
                // Get the author UIDs
                let authorUIDs = self.appointments.map { $0.authorUID }
                
                // Fetch the profile images for the authors
                self.fetchProfileImages(for: authorUIDs)
            }
        }
    }

    func fetchAppointmentsAndDo(for authorUID: String, completion: @escaping () -> Void) {
        isLoading = true
        let db = Firestore.firestore()
        db.collection("appointments").whereField("authorUID", isEqualTo: authorUID).getDocuments { querySnapshot, error in
            if let error = error {
                print("DEBUG: Error getting appointments: \(error)")
                self.isLoading = false
                completion()
            } else if let querySnapshot = querySnapshot {
                self.isLoading = false
                self.appointments = querySnapshot.documents.compactMap { document -> Appointment? in
                    var appointment = try? document.data(as: Appointment.self)
                    appointment?.id = document.documentID
                    return appointment
                }
                completion()
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
