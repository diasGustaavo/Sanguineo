//
//  AddressViewModel.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 14/06/23.
//

import Combine
import CoreLocation
import SwiftUI

class AddressViewModel: ObservableObject {
    
    @Published var addresses: [String] = []
    
    @Published var isSearching: Bool = false

    @Published var selectedAddress: String = "" {
        didSet {
            withAnimation {
                isSearching = !selectedAddress.isEmpty
            }
        }
    }
    
    @Published var typedSearchAddress: String = "" {
        didSet {
            updateSearchedLikeAddresses()
        }
    }
    @Published var searchedLikeAddresses: [String] = []
    
    private var cancellables = Set<AnyCancellable>()

    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()

    init() {
        $typedSearchAddress
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { _ in self.updateSearchedLikeAddresses() }
            .store(in: &cancellables)
    }
    
    func addAddress(_ address: String) {
        addresses.append(address)
    }
    
    func eraseAddress(_ address: String) {
        if let index = addresses.firstIndex(of: address) {
            addresses.remove(at: index)
        }
    }
    
    func addCurrentLocation() {
        if let location = locationManager.location {
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if let placemark = placemarks?.first {
                    let addressString = "\(placemark.locality ?? ""), \(placemark.postalCode ?? ""), \(placemark.country ?? "")"
                    self.addAddress(addressString)
                    self.selectedAddress = addressString
                }
            }
        } else {
            print("Current location not available.")
        }
    }
    
    private func updateSearchedLikeAddresses() {
        geocoder.geocodeAddressString(typedSearchAddress) { [weak self] (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let placemarks = placemarks {
                self?.searchedLikeAddresses = placemarks.compactMap {
                    "\($0.locality ?? ""), \($0.postalCode ?? ""), \($0.country ?? "")"
                }
            }
        }
    }
}
