//
//  Appointment.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 07/07/23.
//

import FirebaseFirestoreSwift
import Firebase

struct Appointment: Identifiable, Codable, Hashable {
    @DocumentID var id: String?  // Document ID
    var appointmentDate: Date    // Appointment Date
    var requestId: String        // ID of the request related to the appointment
    var authorUID: String        // User who created the appointment

    enum CodingKeys: String, CodingKey {
        case id
        case appointmentDate
        case requestId
        case authorUID
    }

    // Init
    init(id: String? = nil, appointmentDate: Date, requestId: String, authorUID: String) {
        self.id = id
        self.appointmentDate = appointmentDate
        self.requestId = requestId
        self.authorUID = authorUID
    }
}
