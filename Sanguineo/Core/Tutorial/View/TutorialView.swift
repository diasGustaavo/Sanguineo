//
//  TutorialView.swift
//  Sanguineo
//
//  Created by Gustavo Dias on 05/05/23.
//

import SwiftUI

struct TutorialView: View {
    @State private var selection = 0
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "AccentColor")!
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                SalveVidasView().tag(0)
                AjudeHemocentrosView().tag(1)
                RecompensasView().tag(2)
                VamosLaView().tag(3)
            }
            .tabViewStyle(.page)
            
            Button {
                if selection != 3 {
                    withAnimation {
                        selection += 1
                    }
                } else {
                    homeViewModel.isTutorialActive = false
                }
            } label: {
                if selection == 3 {
                    Text("Cadastre-se ou Entre")
                        .bold()
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color(UIColor(named: "AccentColor")!))
                        .cornerRadius(7)
                        .padding(.horizontal, 16)
                } else {
                    Text("Próximo")
                        .bold()
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color(UIColor(named: "AccentColor")!))
                        .cornerRadius(7)
                        .padding(.horizontal, 16)
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            if selection != 3 {
                Button {
                    withAnimation {
                        selection = 3
                    }
                } label: {
                    Text("Pular")
                        .foregroundColor(Color(UIColor(named: "AccentColor")!))
                        .padding()
                }
            } else {
                Spacer().frame(height: 60)
            }
            
            Spacer()
        }
    }
}

struct SalveVidasView: View {
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "pose_4")!)

            Text("Salve vidas")
                .font(.custom("Nunito-SemiBold", size: 20))

            Text("O sanguíneo é um indivíduo que atua como intermediário na doação e recepção de sangue entre doadores e receptores.")
                .font(.custom("Nunito-Light", size: 16))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top, 16)
        }
    }
}

struct AjudeHemocentrosView: View {
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "08")!)

            Text("Ajude hemocentros")
                .font(.custom("Nunito-SemiBold", size: 20))

            Text("O Sanguíneo ajuda também os hemocentros a cumprirem suas metas.")
                .font(.custom("Nunito-Light", size: 16))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top, 16)
        }
    }
}

struct RecompensasView: View {
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "0003")!)

            Text("Recompensas")
                .font(.custom("Nunito-SemiBold", size: 20))

            Text("Para estimular a frequência da doação, é possível ganhar recompensas como vouchers no Ifood, Uber, cinema e outras opções.")
                .font(.custom("Nunito-Light", size: 16))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top, 16)
        }
    }
}

struct VamosLaView: View {
    var body: some View {
        VStack {
            Image(uiImage: UIImage(named: "0005")!)

            Text("Vamos lá?")
                .font(.custom("Nunito-SemiBold", size: 20))

            Text("Agora é com você - entre ou crie uma conta e nos ajude a salvar vidas.")
                .font(.custom("Nunito-Light", size: 16))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top, 16)
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
            .environmentObject(HomeViewModel())
    }
}
