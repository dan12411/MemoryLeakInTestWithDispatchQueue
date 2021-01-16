//
//  FeedViewController.swift
//  MemoryLeakInTestWithDispatchQueue
//
//  Created by 洪德晟 on 2021/1/15.
//

import UIKit

class BaseViewController: UIViewController {
  let loadingView = UIView()

  func show() {
    guarenteeMainThread {
      self.loadingView.isHidden = false
    }
  }

  func hide() {
    guarenteeMainThread {
      self.loadingView.isHidden = true
    }
  }

}

final class FeedViewController: BaseViewController {
  private let viewModel: FeedViewModel

  init(viewModel: FeedViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    addLoadingView()
    bindViewModel()
  }

  private func addLoadingView() {
    view.addSubview(loadingView)
    loadingView.frame = view.frame
  }

  private func bindViewModel() {
    viewModel.onLoadingStateChange = { [weak self] isLoading in
      isLoading ? self?.show() : self?.hide()
    }

    viewModel.loadFeed()
  }

}
