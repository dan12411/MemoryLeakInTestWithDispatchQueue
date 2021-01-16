//
//  SceneDelegate.swift
//  iOSMVCExample
//
//  Created by 洪德晟 on 2021/1/16.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = scene as? UIWindowScene else { return }

    let service = AnyService()
    let vc = ViewController.make(service: service)

    window = UIWindow(windowScene: scene)
    window?.rootViewController = vc
    window?.makeKeyAndVisible()
  }

}

final class AnyService: Service {

  func load(completion: @escaping (String) -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
      completion("Hello world!")
    }
  }
}
