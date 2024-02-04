//
//  ViewController.swift
//  VideoInVideo
//
//  Created by Muhammad Irfan on 03/02/2024.
//

import UIKit
import AVKit

final class VideoInVideoController: UIViewController {
  
  private var viewModel: VideoInVideoViewModel
  private let playerViewController = AVPlayerViewController()
  private let containerView = UIView()

  private let pipIconButton: UIButton = {
    let button = UIButton()
    button.setBackgroundImage(UIImage(systemName: "pip"), for: .normal)
    button.tintColor = .white
    button.translatesAutoresizingMaskIntoConstraints = false
    button.isUserInteractionEnabled = true
    return button
  }()
  
  private let expandIconButton: UIButton = {
    let button = UIButton()
    button.setBackgroundImage(UIImage(systemName: "arrow.up.left.and.arrow.down.right"), for: .normal)
    button.tintColor = .white
    button.translatesAutoresizingMaskIntoConstraints = false
    button.isUserInteractionEnabled = true
    button.isHidden = true
    return button
  }()

  private let defaultLogo: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "aion"))
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  init(viewModel: VideoInVideoViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(handleDeviceRotation), name: UIDevice.orientationDidChangeNotification, object: nil)

    setupPlayer()
    setupViews()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    playerViewController.player?.play()
  }

  func setupPlayer() {
    // Set up video player
    guard let videoURL = viewModel.getVideoURL() else {
      let alert = UIAlertController(title: "Alert", message: "Invalid URL of video", preferredStyle: .alert)
      present(alert, animated: true)
      return
    }
    let playerItem = AVPlayerItem(url: videoURL)

    // Create an AVPlayer with the AVPlayerItem
    let player = AVPlayer(playerItem: playerItem)
    playerViewController.player = player
    addChild(playerViewController)
  }

  func setupViews() {

    // Set up container view
    view.addSubview(defaultLogo)
    containerView.addSubview(playerViewController.view)
    view.addSubview(containerView)
    containerView.frame = view.bounds

    playerViewController.view.frame = containerView.bounds
    playerViewController.didMove(toParent: self)
    
    // Add default logo in container
    NSLayoutConstraint.activate([
      defaultLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      defaultLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      defaultLogo.widthAnchor.constraint(equalToConstant: 300),
      defaultLogo.heightAnchor.constraint(equalToConstant: 130)
    ])

    // Add pip icon in container
    view.addSubview(pipIconButton)
    NSLayoutConstraint.activate([
      pipIconButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
      pipIconButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
      pipIconButton.widthAnchor.constraint(equalToConstant: 24),
      pipIconButton.heightAnchor.constraint(equalToConstant: 24)
    ])

    // Add expand icon in container
    containerView.addSubview(expandIconButton)
    NSLayoutConstraint.activate([
      expandIconButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
      expandIconButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
      expandIconButton.widthAnchor.constraint(equalToConstant: 24),
      expandIconButton.heightAnchor.constraint(equalToConstant: 24)
    ])

    pipIconButton.addTarget(self, action: #selector(pipAction), for: .touchUpInside)
    expandIconButton.addTarget(self, action: #selector(expandAction), for: .touchUpInside)
  }

  @objc func pipAction() {
    viewModel.videoMode = .pip
    handleVideoMode()
  }

  @objc func expandAction() {
    viewModel.videoMode = .expand
    handleVideoMode()
  }

  func handleVideoMode() {

    UIView.animate(withDuration: 0.3) {
      DispatchQueue.main.async {
         updateView()
      }
    }
    //handling video state
    func updateView() {
      switch viewModel.videoMode {
      case .pip:
        containerView.frame = viewModel.getPipContainerFrame(rect: view.bounds)
        pipIconButton.isHidden = true
        expandIconButton.isHidden = false
      case .expand:
        containerView.frame = view.bounds
        pipIconButton.isHidden = false
        expandIconButton.isHidden = true
      }
    }
  }

  @objc func handleDeviceRotation() {

    DispatchQueue.main.async {
      updateView()
    }
    //handling video state with device rotation
    func updateView() {
      switch viewModel.videoMode {
      case .pip:
        containerView.frame = viewModel.getPipContainerFrame(rect: view.bounds)
      case .expand:
        containerView.frame = viewModel.getFullContainerFrame(rect: view.bounds)
        playerViewController.view.frame = containerView.bounds
      }
    }
  }

  deinit {
    // Remove observer to avoid memory leaks
    NotificationCenter.default.removeObserver(self)
  }
}
