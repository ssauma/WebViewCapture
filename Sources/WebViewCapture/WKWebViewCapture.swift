//
//  WKWebViewCapture.swift
//  WKWebViewCapture
//
//  Created by Juyeon Lee on 2022/01/07.
//

import Foundation
import WebKit

extension WKWebView {
    func image(_ elementId: String, completion: @escaping (UIImage?) -> Void) {
        guard !elementId.isEmpty else {
            completion(nil)
            return
        }
        let webView = self
        webView.evaluateJavaScript("document.readyState", completionHandler: { (readyState, readyStateError) in
            guard readyStateError == nil else {
                completion(nil)
                return
            }
            webView.evaluateJavaScript("document.getElementById('\(elementId)').clientWidth", completionHandler: {(contentWidth, widthError) in
                webView.evaluateJavaScript("document.getElementById('\(elementId)').clientHeight", completionHandler: { (contentHeight, heightError) in
                    webView.evaluateJavaScript("document.getElementById('\(elementId)').getBoundingClientRect().left + document.body.scrollLeft", completionHandler: {(contentX, xError) in
                        webView.evaluateJavaScript("document.getElementById('\(elementId)').getBoundingClientRect().top + document.body.scrollTop", completionHandler: { (contentY, yError) in
                            guard readyState != nil,
                                  let contentX = contentX as? CGFloat,
                                  let contentY = contentY as? CGFloat,
                                  let contentHeight = contentHeight as? CGFloat,
                                  let contentWidth = contentWidth as? CGFloat else {
                                      return
                                  }
                            let rect = CGRect(
                                x: contentX,
                                y: contentY,
                                width: contentWidth,
                                height: contentHeight
                            )
                            
                            let configuration = WKSnapshotConfiguration()
                            configuration.rect = rect
                            
                            if #available(iOS 13.0, *) {
                                configuration.afterScreenUpdates =  true
                            }
                            
                            webView.takeSnapshot(with: configuration) { (snapshotImage, error) in
                                completion(snapshotImage)
                            }
                        })
                    })
                })
            })
        })
    }
}
 
@available(iOS 15.0.0, *)
extension WKWebView {
    func image(_ elementId: String) async -> UIImage? {
        guard !elementId.isEmpty else {
            return nil
        }
        do {
            let readyState = try await evaluateJavaScript("document.readyState")
            let contentWidth = try await evaluateJavaScript("document.getElementById('\(elementId)').clientWidth")
            let contentHeight = try await evaluateJavaScript("document.getElementById('\(elementId)').clientHeight")
            let contentX = try await evaluateJavaScript("document.getElementById('\(elementId)').getBoundingClientRect().left + document.body.scrollLeft")
            let contentY = try await evaluateJavaScript("document.getElementById('\(elementId)').getBoundingClientRect().top + document.body.scrollTop")
            
            guard let readyState = readyState as? String, readyState == "complate",
                  let contentX = contentX as? CGFloat,
                  let contentY = contentY as? CGFloat,
                  let contentHeight = contentHeight as? CGFloat,
                  let contentWidth = contentWidth as? CGFloat else {
                      return nil
                  }
            
            let rect = CGRect(
                x: contentX,
                y: contentY,
                width: contentWidth,
                height: contentHeight
            )
            
            let configuration = WKSnapshotConfiguration()
            configuration.rect = rect
            configuration.afterScreenUpdates = true
            
            return try await takeSnapshot(configuration: configuration)
        } catch {
            return nil
        }
    }
}
