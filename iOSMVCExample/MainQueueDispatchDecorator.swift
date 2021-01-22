//
//  MainQueueDispatchDecorator.swift
//  iOSMVCExample
//
//  Created by 洪德晟 on 2021/1/16.
//

import Foundation

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

extension MainQueueDispatchDecorator: Service where T == Service {
  func load(completion: @escaping (String) -> Void) {
    decoratee.load { [weak self] result in
      self?.dispatch { completion(result) }
    }
  }
}
