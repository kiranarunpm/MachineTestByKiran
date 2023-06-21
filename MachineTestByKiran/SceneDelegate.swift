//
//  SceneDelegate.swift
//  MachineTestByKiran
//
//  Created by Kiran PM on 20/06/23.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var rootVC = RootVC()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = rootVC.GetRootVC()
        self.window?.makeKeyAndVisible()
        guard let _ = (scene as? UIWindowScene) else { return }
    }

}

