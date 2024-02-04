//
//  VideoInVideoViewModel.swift
//  VideoInVideo
//
//  Created by Muhammad Irfan on 03/02/2024.
//

import UIKit

enum VideoMode {
  case pip
  case expand
}

struct VideoInVideoViewModel {
  
  private let videoURL: String
  let minimizedWidth = 150.0
  let minimizedHeight = 100.0
  var videoMode: VideoMode = .expand
  
  init(videoURL: String) {
    self.videoURL = videoURL
  }

  func getVideoURL()-> URL? {
    guard let videoURL = URL(string: videoURL) else {
        return nil
    }
    return videoURL
  }

  func getPipContainerFrame(rect: CGRect)-> CGRect {
    let x = rect.width - minimizedWidth - 20
    let y = rect.height - minimizedHeight - 100

    return CGRect(x: x, y: y, width: minimizedWidth, height: minimizedHeight)
  }

  func getFullContainerFrame(rect: CGRect)-> CGRect {
    return CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
  }
}
