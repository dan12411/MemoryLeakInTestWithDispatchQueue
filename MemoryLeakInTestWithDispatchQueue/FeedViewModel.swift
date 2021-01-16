//
//  FeedViewModel.swift
//  MemoryLeakInTestWithDispatchQueue
//
//  Created by 洪德晟 on 2021/1/15.
//

import Foundation

final class FeedViewModel {
  typealias Loader = FeedUIComposer.Loader
  typealias Observer<T> = (T) -> Void

  private let loader: Loader

  var onLoadingStateChange: Observer<Bool>?

  init(loader: @escaping Loader) {
    self.loader = loader
  }

  func loadFeed() {
    onLoadingStateChange?(true)
    loader { [weak self] _ in
      self?.onLoadingStateChange?(false)
    }
  }

}
