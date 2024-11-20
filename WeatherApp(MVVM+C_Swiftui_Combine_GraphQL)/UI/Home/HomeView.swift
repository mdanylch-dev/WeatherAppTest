//
//  HomeView.swift
//  WeatherApp(MVVM+C_Swiftui_Combine_GraphQL)
//
//  Created by Nikita Danylchenko on 08.05.2022.
//

import SwiftUI

struct HomeView<VM>: View where VM: HomeViewModelType {
    @ObservedObject var viewModel: VM

    let widthHalfScreen: CGFloat = UIScreen.main.bounds.width / 2
    let paddingTop: CGFloat = 50
    let paddingBottom: CGFloat = 40

    var body: some View {
        ZStack(alignment: .top) {
            background

            VStack(alignment: .center, spacing: 10) {
                mainInfo
                Spacer()
                buttonToSearch
            }
            .padding(.horizontal, 16)
            .navigationBarHidden(true)
            .padding(.top, paddingTop)
            .padding(.bottom, paddingBottom)

            buttonAddToFavorites
        }
    }

    private var mainInfo: some View {
        Group {
            Text("\(self.viewModel.weather?.name ?? "Kyiv"), \(self.viewModel.weather?.country ?? "UA")")
                .lineLimit(1)
                .font(.system(size: 32, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: "cloud.sun.fill")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: widthHalfScreen, height: widthHalfScreen)
            Text("\(String(format: "%.0f", self.viewModel.weather?.temperatureActual ?? 15.0))°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
            Text("\(self.viewModel.weather?.weatherDescription ?? "partly cloudy")".capitalized)
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.white)
                .padding(.top, 5)
            HStack(spacing: 16) {
                Text("H: \(String(format: "%.0f", self.viewModel.weather?.temperatureMax ?? 20.0))°")
                    .font(.system(size: 25, weight: .medium))
                    .foregroundColor(.white)
                Text("L: \(String(format: "%.0f", self.viewModel.weather?.temperatureMin ?? 5.0))°")
                    .font(.system(size: 25, weight: .medium))
                    .foregroundColor(.white)
            }
        }
    }

    private var buttonToSearch: some View {
        Button {
            viewModel.goToFavorites()
        } label: {
            Text("Change city")
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(.white)
                .font(.system(size: 20, weight: .medium, design: .default))
                .cornerRadius(10)
        }
    }

    private var buttonAddToFavorites: some View {
        HStack {
            Spacer()
            Button(action: {
                self.viewModel.addToFavorites()
            }, label: {
                Image(systemName: "plus.app")
                    .resizable()
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.white)
                    .frame(width: 40, height: 40)
            })
        }
        .padding(.trailing, 16)
    }

    private var background: some View {
        LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.vertical)
    }
}

// MARK: - Preview
#if DEBUG

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}

#endif
