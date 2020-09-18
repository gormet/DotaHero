//
//  SceneDelegate.swift
//  DotaHero
//
//  Created by Septian on 9/16/20.
//  Copyright © 2020 Septian. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let _ = (scene as? UIWindowScene) else { return }
    let heroListVC = HeroListViewController()
    window?.rootViewController = heroListVC
  }

  func sceneDidDisconnect(_ scene: UIScene) {
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
  }

  func sceneWillResignActive(_ scene: UIScene) {}

  func sceneWillEnterForeground(_ scene: UIScene) {
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
  }


}

