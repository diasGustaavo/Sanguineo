//
//  FeedView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 30/05/23.
//

import SwiftUI
import SwiftUIPullToRefresh

struct FeedView: View {
    @EnvironmentObject var feedViewModel: FeedViewModel
    @EnvironmentObject var addressViewModel: AddressViewModel
    @EnvironmentObject var initialLogViewModel: InitialLogViewModel
    
    @ObservedObject var navigationBarViewModel: NavigationBarViewModel
    
    @State private var showingAddressView = false
    @State private var showingDonationView = false
    
    @State private var isOrderedByProximity = false
    @State private var isOrderedByUrgency = false
    
    var body: some View {
        NavigationView {
            RefreshableScrollView(onRefresh: { done in
                feedViewModel.restoreOriginalOrder()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
                    // HEADER
                    HStack {
                        Image(uiImage: UIImage(named: "bloodtype")!)
                            .resizable()
                            .frame(width: 30 ,height: 30)
                        
                        Text(initialLogViewModel.currentUser?.bloodtype ?? "")
                            .font(.custom("Nunito-Regular", size: 16))
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Text((addressViewModel.selectedAddress?.street.map { String($0.prefix(22)) + ($0.count > 25 ? "..." : "") } ?? "Sem endereço selecionado"))
                            .font(.custom("Nunito-Light", size: 16))
                            .multilineTextAlignment(.center)
                            .onTapGesture {
                                showingAddressView = true
                            }
                            .sheet(isPresented: $showingAddressView) {
                                AddressView()
                            }
                        
                        Image(systemName: "chevron.down")
                            .font(.custom("Nunito-Light", size: 14))
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Image(systemName: "bell")
                            .font(.custom("Nunito-Semibold", size: 20))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 16)
                    
                    // FILTERS
                    HStack {
                        HStack {
                            Image(systemName: "line.horizontal.3.decrease")
                                .padding(.leading)
                            
                            Text("Filtros")
                                .font(.custom("Nunito-Regular", size: 14))
                                .frame(height: 40)
                                .foregroundColor(Color(uiColor: UIColor(named: "frontColor")!))
                                .padding(.trailing)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color(UIColor(named: "AccentColor")!), lineWidth: 1)
                        )
                        
                        Spacer()
                        
                        Button(action: {
                            if let selectedAddress = addressViewModel.selectedAddress {
                                isOrderedByProximity.toggle()
                                
                                if isOrderedByProximity {
                                    feedViewModel.orderByProximity(coordinateX: selectedAddress.coordinateX, coordinateY: selectedAddress.coordinateY)
                                } else {
                                    feedViewModel.restoreOriginalOrder()
                                }
                            } else {
                                print("DEBUG: No selected addresss")
                            }
                        }) {
                            Text("Mais Próximos")
                                .font(.custom("Nunito-Regular", size: 14))
                                .multilineTextAlignment(.center)
                                .frame(height: 40)
                                .padding(.horizontal)
                                .foregroundColor(Color(uiColor: UIColor(named: isOrderedByProximity ? "backColor" : "frontColor")!))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 7)
                                        .stroke(Color(UIColor(named: "AccentColor")!), lineWidth: 1)
                                )
                                .background(isOrderedByProximity ? Color(UIColor(named: "AccentColor")!) : Color(UIColor(named: "backColor")!))
                                .cornerRadius(7)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            isOrderedByUrgency.toggle()
                            
                            if isOrderedByUrgency {
                                feedViewModel.orderByTrueBooleans()
                            } else {
                                feedViewModel.restoreOriginalOrder()
                            }
                        }) {
                            Text("Urgência")
                                .font(.custom("Nunito-Regular", size: 14))
                                .multilineTextAlignment(.center)
                                .frame(height: 40)
                                .padding(.horizontal)
                                .foregroundColor(Color(uiColor: UIColor(named: isOrderedByUrgency ? "backColor" : "frontColor")!))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 7)
                                        .stroke(Color(UIColor(named: "AccentColor")!), lineWidth: 1)
                                )
                                .background(isOrderedByUrgency ? Color(UIColor(named: "AccentColor")!) : Color(UIColor(named: "backColor")!))
                                .cornerRadius(7)
                        }
                    }
                    .padding(.horizontal, 22)
                    
                    HStack {
                        Text("Essas pessoas precisam de sua ajuda")
                            .font(.custom("Nunito-Bold", size: 18))
                            .multilineTextAlignment(.leading)
                        
                        Spacer().frame(width: 100)
                        
                        NavigationLink {
                            DetailedFeedCategoryView(sectionDescription: "Essas pessoas precisam de sua ajuda", requesters: feedViewModel.individuals) {
                                // some action
                            }
                        } label: {
                            Text("Expandir")
                                .font(.custom("Nunito-Regular", size: 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.accentColor)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                    
                    
                    if !feedViewModel.individualsLoading {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(feedViewModel.individuals, id: \.self) { individual in
                                    ReusablePersonCellView(image: UIImage(named: "3d_avatar_28")!, name: individual.name, bloodtype: individual.bloodtype, age: individual.age, description: individual.description) {
                                        showingDonationView = true
                                        navigationBarViewModel.reqUID = individual.id
                                    }
                                    .sheet(isPresented: $showingDonationView) {
                                        DonateView(navigationBarViewModel: navigationBarViewModel)
                                    }
                                }
                            }
                            .padding(.vertical)
                        }
                        .padding(.leading, 16)
                    } else {
                        VStack {
                            Spacer()
                                .frame(height: 40)
                            
                            Spinner(lineWidth: 5, height: 32, width: 32)
                            
                            Spacer()
                                .frame(height: 20)
                        }
                    }
                    
                    HStack {
                        Text("Campanhas de doações")
                            .font(.custom("Nunito-Bold", size: 18))
                            .multilineTextAlignment(.leading)
                        
                        Spacer().frame(width: 80)
                        
                        NavigationLink {
                            DetailedFeedCategoryView(sectionDescription: "Campanhas de doações", requesters: feedViewModel.hospitals) {
                                // some action
                            }
                        } label: {
                            Text("Expandir")
                                .font(.custom("Nunito-Regular", size: 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.accentColor)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                    
                    if !feedViewModel.hospitalsLoading {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(feedViewModel.hospitals, id: \.self) { hospital in
                                    ReusablePersonCellView(image: UIImage(named: "3d_avatar_28")!, name: hospital.name, bloodtype: hospital.bloodtype, age: nil, description: hospital.description) {
                                        showingDonationView = true
                                        navigationBarViewModel.reqUID = hospital.id
                                    }
                                    .sheet(isPresented: $showingDonationView) {
                                        DonateView(navigationBarViewModel: navigationBarViewModel)
                                    }
                                }
                            }
                            .padding(.vertical)
                        }
                        .padding(.leading, 16)
                    } else {
                        VStack {
                            Spacer()
                                .frame(height: 40)
                            
                            Spinner(lineWidth: 5, height: 32, width: 32)
                            
                            Spacer()
                                .frame(height: 20)
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(navigationBarViewModel: NavigationBarViewModel())
            .environmentObject(FeedViewModel())
            .environmentObject(AddressViewModel())
            .environmentObject(InitialLogViewModel())
    }
}
