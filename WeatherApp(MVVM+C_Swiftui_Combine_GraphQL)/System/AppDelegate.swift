//
//  AppDelegate.swift
//  WeatherApp(MVVM+C_Swiftui_Combine_GraphQL)
//
//  Created by Nikita Danylchenko on 08.05.2022.
//

import UIKit
import Combine

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: HomeCoordinator?
    var cancelBag = CancelBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        appCoordinator = HomeCoordinator(window: window!)
        appCoordinator?.start().sink(receiveValue: {}).store(in: cancelBag)

        return true
    }

}
