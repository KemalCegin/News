//
//  News.swift
//  News
//
//  Created by Kemal Cegin on 4.01.2023.
//
enum NewsCategory: String, Codable {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}

struct News: Codable, Hashable  {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let content : String?
    let publishedAt : String?
    let category : NewsCategory?
}

struct NewsEnvelope: Decodable {
    let status: String
    let totalResults: Int
    let articles: [News]
}
