//
//  MainQueueDispatchDecorator.swift
//  MemoryLeakInTestWithDispatchQueue
//
//  Created by 洪德晟 on 2021/1/15.
//

import Foundation

final class MainQueueDispatchDecorator<T> {
  private let decoratee: T

  init(decoratee: T) {
    self.decoratee = decoratee
  }

  func dispatch(completion: @escaping () -> Void) {
    guarenteeMainThread(completion)
  }
}

func guarenteeMainThread(_ work: @escaping () -> Void) {
  if Thread.isMainThread {
    work()
  } else {
    DispatchQueue.main.async(execute: work)
  }
}

extension MainQueueDispatchDecorator where T == FeedUIComposer.Loader {
  func load(completion: @escaping FeedUIComposer.Completion) {
    decoratee { [weak self] result in
      self?.dispatch { completion(result) }
    }
  }
}
