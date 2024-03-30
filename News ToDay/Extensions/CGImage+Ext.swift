//
//  CGImage+Ext.swift
//  News ToDay
//
//  Created by Mikhail Ustyantsev on 28.03.2024.
//

import CoreGraphics

extension CGImage {
  public var hasCGContextSupportedPixelFormat: Bool {
    guard let colorSpace = self.colorSpace else {
      return false
    }
    #if os(iOS) || os(watchOS) || os(tvOS)
    let iOS = true
    #else
    let iOS = false
    #endif

    #if os(OSX)
    let macOS = true
    #else
    let macOS = false
    #endif
    switch (colorSpace.model, bitsPerPixel, bitsPerComponent, alphaInfo, bitmapInfo.contains(.floatComponents)) {
    case (.unknown, 8, 8, .alphaOnly, _):
      return macOS || iOS
    case (.monochrome, 8, 8, .none, _):
      return macOS || iOS
    case (.monochrome, 8, 8, .alphaOnly, _):
      return macOS || iOS
    case (.monochrome, 16, 16, .none, _):
      return macOS
    case (.monochrome, 32, 32, .none, true):
      return macOS
    case (.rgb, 16, 5, .noneSkipFirst, _):
      return macOS || iOS
    case (.rgb, 32, 8, .noneSkipFirst, _):
      return macOS || iOS
    case (.rgb, 32, 8, .noneSkipLast, _):
      return macOS || iOS
    case (.rgb, 32, 8, .premultipliedFirst, _):
      return macOS || iOS
    case (.rgb, 32, 8, .premultipliedLast, _):
      return macOS || iOS
    case (.rgb, 64, 16, .premultipliedLast, _):
      return macOS
    case (.rgb, 64, 16, .noneSkipLast, _):
      return macOS
    case (.rgb, 128, 32, .noneSkipLast, true):
      return macOS
    case (.rgb, 128, 32, .premultipliedLast, true):
      return macOS
    case (.cmyk, 32, 8, .none, _):
      return macOS
    case (.cmyk, 64, 16, .none, _):
      return macOS
    case (.cmyk, 128, 32, .none, true):
      return macOS
    default:
      return false
    }
  }
}
