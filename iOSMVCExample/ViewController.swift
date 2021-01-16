//
//  ViewController.swift
//  iOSMVCExample
//
//  Created by 洪德晟 on 2021/1/16.
//

import UIKit

public protocol Service {

   func load(completion: @escaping (String) -> Void)
}

public class ViewController: UIViewController {
  @IBOutlet public var label: UILabel!
  private var service: Service!

  public override func viewDidLoad() {
    super.viewDidLoad()

    label.text = "Loading..."
    service.load { [weak self] text in
      self?.label.text = text
    }
  }
}

public extension ViewController {
  static func make(service: Service) -> ViewController {
    let sb = UIStoryboard(name: "Main", bundle: nil)

    return sb.instantiateViewController(identifier: "ViewController") {
      let vc = ViewController(coder: $0)
      vc?.service = service
      return vc
    }
  }
}

