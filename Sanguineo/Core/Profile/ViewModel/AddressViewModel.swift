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
    
    @Published var addresses: [String] = []
    @Published var isSearching: Bool = false;
    @Published var selectedAddress: String = "";
    @Published var currentLocation: String = "";
    
    @Published var typedSearchAddress: String = "" {
        didSet {
            withAnimation {
                isSearching = !typedSearchAddress.isEmpty
            }
        }
    }
    
    @Published var searchedLikeAddresses: [String] = []
    
    private var cancellables = Set<AnyCancellable>()

    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()

    init() {
        $typedSearchAddress
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [unowned self] in
                if !$0.isEmpty {
                    self.updateSearchedLikeAddresses()
                }
            }
            .store(in: &cancellables)
    }
    
    func addAddress(_ address: String) {
        addresses.append(address)
        selectedAddress = address
    }
    
    func eraseAddress(_ address: String) {
        if let index = addresses.firstIndex(of: address) {
            addresses.remove(at: index)
        }
    }
    
    func addCurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
        if let location = locationManager.location {
            geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if let placemark = placemarks?.first {
                    var components: [String] = []
                    guard let street = placemark.thoroughfare else {
                        print("No thoroughfare available.")
                        return
                    }
                    if let number = placemark.subThoroughfare {
                        components.append("\(street) \(number)")
                    } else {
                        components.append(street)
                    }
                    if let neighborhood = placemark.subLocality {
                        components.append(neighborhood)
                    }
                    if let city = placemark.locality {
                        components.append(city)
                    }
                    if let state = placemark.administrativeArea {
                        components.append(state)
                    }
                    let addressString = components.joined(separator: ", ")
                    self?.addAddress(addressString)
                    self?.selectedAddress = addressString
                    self?.currentLocation = addressString
                }
            }
        } else {
            print("Current location not available.")
        }
    }
    
    private func updateSearchedLikeAddresses() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = typedSearchAddress

        let search = MKLocalSearch(request: request)
        search.start { [weak self] (response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            if let mapItems = response?.mapItems {
                print(mapItems.count)
                self?.searchedLikeAddresses = mapItems.compactMap {
                    var components: [String] = []
                    guard let street = $0.placemark.thoroughfare else {
                        return nil
                    }
                    if let number = $0.placemark.subThoroughfare {
                        components.append("\(street) \(number)")
                    } else {
                        components.append(street)
                    }
                    if let neighborhood = $0.placemark.subLocality {
                        components.append(neighborhood)
                    }
                    if let city = $0.placemark.locality {
                        components.append(city)
                    }
                    if let state = $0.placemark.administrativeArea {
                        components.append(state)
                    }
                    return components.joined(separator: ", ")
                }
            }
        }
    }
}
