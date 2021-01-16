//
//  FeedUIComposer.swift
//  MemoryLeakInTestWithDispatchQueue
//
//  Created by 洪德晟 on 2021/1/15.
//

import UIKit

final class FeedUIComposer {
  typealias Completion = (Result<[String], Error>) -> Void
  typealias Loader = (@escaping Completion) -> Void

  private init() {}

  public static func feedComposedWith(loader: @escaping Loader) -> FeedViewController {
    let viewModel = FeedViewModel(loader: MainQueueDispatchDecorator(decoratee: loader).load)

    return FeedViewController(viewModel: viewModel)
  }
}
