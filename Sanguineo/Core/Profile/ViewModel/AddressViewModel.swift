//
//  AddressViewModel.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 14/06/23.
//

import Combine
import CoreLocation
import SwiftUI
import MapKit

class AddressViewModel: ObservableObject {
    
    @Published var addresses: [Address] = []
    @Published var isSearching: Bool = false;
    @Published var currentLocation: Address?;
    
    @Published var typedSearchAddress: String = "" {
        didSet {
            withAnimation {
                isSearching = !typedSearchAddress.isEmpty
            }
        }
    }
    
    @Published var searchedLikeAddresses: [Address] = []
    
    @Published var selectedAddress: Address? {
        didSet {
            guard let address = selectedAddress else { return }
            
            // update address in Firestore
            UserService.shared.updateUser(location: User.Location(latitude: address.coordinateY, longitude: address.coordinateX))
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    init() {
        addCurrentLocation()
        
        $typedSearchAddress
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [unowned self] in
                if !$0.isEmpty {
                    self.updateSearchedLikeAddresses()
                }
            }
            .store(in: &cancellables)
    }
    
    func addAddress(_ address: Address) {
        addresses.append(address)
        selectedAddress = address
        typedSearchAddress = ""
    }
    
    func eraseAddress(_ address: Address) {
        if let index = addresses.firstIndex(of: address) {
            addresses.remove(at: index)
        }
    }
    
    func addCurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
        if let location = locationManager.location {
            geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
                if error != nil {
                    return
                }
                
                if let placemark = placemarks?.first {
                    let street = placemark.thoroughfare
                    let number = placemark.subThoroughfare
                    let neighborhood = placemark.subLocality
                    let city = placemark.locality
                    let state = placemark.administrativeArea
                    
                    let address = Address(street: street,
                                          number: number,
                                          neighborhood: neighborhood,
                                          city: city,
                                          state: state,
                                          coordinateX: location.coordinate.longitude,
                                          coordinateY: location.coordinate.latitude)
                    
                    self?.addAddress(address)
                    self?.selectedAddress = address
                    self?.currentLocation = address
                }
            }
        } else {
            print("DEBUG: Current location not available.")
        }
    }
    
    private func updateSearchedLikeAddresses() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = typedSearchAddress

        let search = MKLocalSearch(request: request)
        search.start { [weak self] (response, error) in
            if error != nil {
                return
            }

            if let mapItems = response?.mapItems {
                print(mapItems)
                self?.searchedLikeAddresses = mapItems.compactMap {
                    guard let street = $0.placemark.thoroughfare else { return nil }
                    let number = $0.placemark.subThoroughfare
                    let neighborhood = $0.placemark.subLocality
                    let city = $0.placemark.locality
                    let state = $0.placemark.administrativeArea

                    return Address(street: street,
                                   number: number,
                                   neighborhood: neighborhood,
                                   city: city,
                                   state: state,
                                   coordinateX: $0.placemark.coordinate.longitude,
                                   coordinateY: $0.placemark.coordinate.latitude)
                }
            }
        }
    }
}
