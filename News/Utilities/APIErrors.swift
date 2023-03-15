//
//  APIErrors.swift
//  News
//
//  Created by Kemal Cegin on 4.01.2023.
//

import Foundation

import Foundation

enum APIErrors: String, Error {
case unableToComplete   = "Unable to complete your request.Please check your internet connection"
case invalidResponse    = "Invalid response from the server.Please try again"
case invalidData        = "The data received from the server was invalid.Please try again"
case  hataburada1 = "Sorry.Unable to favorite."
    case hataburada2 = "hata"
case alreadyInBookMark = "This article already in bookmarks."
}

