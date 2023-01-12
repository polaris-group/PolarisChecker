//
//  TabList.swift
//  Checker
//
//  Created by polaris dev on 2023/1/12.
//

import Foundation

struct TabList: Codable {
    let version: Int
    let list: [TabItem]
}

struct TabItem: Codable {
    let id: Int
    let nameMap: [String: String]
    let list: [TemplateItem]
}

struct TemplateItem: Codable {
    let id: Int
    let isVip: Bool?
    let imageUrl: String?
    let sourceUrl: String?
    
    let imageWidth: CGFloat?
    let imageHeight: CGFloat?
}

extension TabList {
    var allTemplateIds: [Int] {
        return Array(Set(list.reduce([]) { $0 + $1.list.map { $0.id } }))
    }
}

extension TemplateItem {
    var fromRemote: Bool {
        return (imageUrl != nil || sourceUrl != nil || imageWidth != nil || imageHeight != nil)
    }
}
