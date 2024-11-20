//
//  FavoriteView.swift
//  WeatherApp(MVVM+C_Swiftui_Combine_GraphQL)
//
//  Created by Nikita Danylchenko on 08.05.2022.
//

import SwiftUI

struct SecondView<VM>: View where VM: SecondViewModelType {
    @ObservedObject var viewModel: VM

    var body: some View {
        VStack {
            TextField("Text", text: $viewModel.text)

            Button(action: {
                viewModel.close()
            }, label: {
                Text("Back")
            })
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing: 16) {
                    ForEach(0 ..< self.viewModel.city.count, id: \.self) {value in
                        Text(String(self.viewModel.city[value]))
                            }
                }
                .padding(.top, 44)
            })
            .clipped()
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

