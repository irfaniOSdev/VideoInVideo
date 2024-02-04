//
//  SceneDelegate.swift
//  VideoInVideo
//
//  Created by Muhammad Irfan on 03/02/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)

    // Change the URL as you want, however don't use youtube urls as they are not supported and to support them, it requires to build youtube player.
    let viewModel = VideoInVideoViewModel(videoURL: "https://t.ly/9EIy-")
    let controller = VideoInVideoController(viewModel: viewModel)
    
    window?.rootViewController = controller
    window?.makeKeyAndVisible()

  }
}

