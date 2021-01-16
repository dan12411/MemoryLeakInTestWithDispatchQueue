//
//  iOSMVCExampleTests.swift
//  iOSMVCExampleTests
//
//  Created by 洪德晟 on 2021/1/16.
//

import XCTest
@testable import iOSMVCExample

class iOSMVCExampleTests: XCTestCase {

  func test_viewDidLoad_rendersStringFromService() {
    let service = ServiceSpy()
    let sut = ViewController.make(service: service)

    sut.loadViewIfNeeded()
    XCTAssertEqual(sut.label.text, "Loading...")

    service.completion?("a string")
    XCTAssertEqual(sut.label.text, "a string")
  }

  // Helpers:

  private class ServiceSpy: Service {
    var completion: ((String) -> Void)?

    func load(completion: @escaping (String) -> Void) {
      self.completion = completion
    }
  }
}
