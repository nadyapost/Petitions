//
//  Petition.swift
//  Project 7
//
//  Created by Nadya Postriganova on 13/4/19.
//  Copyright © 2019 Nadya Postriganova. All rights reserved.
//

import Foundation

struct Petition: Codable {
  var title: String
  var body: String
  var signatureCount: Int
}
