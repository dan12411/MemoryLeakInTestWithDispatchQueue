//
//  MemoryLeakInTestWithDispatchQueueTests.swift
//  MemoryLeakInTestWithDispatchQueueTests
//
//  Created by 洪德晟 on 2021/1/15.
//

import XCTest
@testable import MemoryLeakInTestWithDispatchQueue

class MemoryLeakInTestWithDispatchQueueTests: XCTestCase {

  func test_loadFeedActions_requestFeedFromLoader() {
    let (sut, loader) = makeSUT()
    XCTAssertEqual(loader.loadRecordCallCount, 0, "Expected no loading requests before view is loaded")

    sut.loadViewIfNeeded()
    XCTAssertEqual(loader.loadRecordCallCount, 1, "Expected a loading request once view is loaded")
  }

  // MARK: - Helpers

  class LoaderSpy {

    var loadRecordCallCount: Int = 0

    public func load(completion: @escaping ((Result<[String], Error>) -> Void)) {
      loadRecordCallCount += 1
    }
  }

  private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: FeedViewController, loader: LoaderSpy) {
    let loader = LoaderSpy()
    let sut = FeedUIComposer.feedComposedWith(loader: loader.load)
    trackForMemoryLeaks(sut, file: file, line: line)
    trackForMemoryLeaks(loader, file: file, line: line)
    return (sut, loader)
  }
}

extension XCTestCase {
  func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
    addTeardownBlock { [weak instance] in
      XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
    }
  }
}
