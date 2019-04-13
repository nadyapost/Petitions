//
//  DetailViewController.swift
//  Project 7
//
//  Created by Nadya Postriganova on 13/4/19.
//  Copyright © 2019 Nadya Postriganova. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
  var webView: WKWebView!
  var detailItem: Petition?
  
  override func loadView() {
    webView = WKWebView()
    view = webView
  }

    override func viewDidLoad() {
        super.viewDidLoad()
      
      guard let detailItem = detailItem else { return }
      
      let html = """
      <html>
      <head>
      <script src="https://code.jquery.com/jquery-3.1.1.min.js" crossorigin="anonymous"></script>
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
      <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"></script>

      <meta name="viewport" content="width=device-width, initial-scale=1">
      </head>
      <body>
        <h1 class="ui header">\(detailItem.title)</h1>
        <p>
          \(detailItem.body)
        </p>
        <p><strong><i class="heart icon"></i> Signatures: \(detailItem.signatureCount)</strong></p>
      </body>
      </html>
      """
      
      webView.loadHTMLString(html, baseURL: nil)
    }
    


}
