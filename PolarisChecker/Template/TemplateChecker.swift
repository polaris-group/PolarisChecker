//
//  TemplateChecker.swift
//  Checker
//
//  Created by polaris dev on 2023/1/12.
//

import Foundation

struct TemplateChecker {
    
    static let checker = TemplateChecker()
    
}

// check tab
extension TemplateChecker {
    
    func checkTab() {
        Task {
            let tabList: TabList? = await loadTab()
            guard let tabList else { return }

            let duplcateTemplateIds = checkDuplicate(tabList)
            if !duplcateTemplateIds.isEmpty {
                print("duplcateTemplateIds: \(duplcateTemplateIds)")
            }
            
            let items = checkTabFormat(tabList.list.reduce([]) { $0 + $1.list })
            items.forEach { print("template id: \($0.id), value: \(DJEncoder($0).encode())") }
        }
    }
    
    func checkTabFormat(_ items: [TemplateItem]) -> [TemplateItem] {
        return items.compactMap { item in
            guard item.fromRemote else { return nil }
            guard let imageUrl = item.imageUrl, !imageUrl.isEmpty else { return item }
            guard let sourceUrl = item.sourceUrl, !sourceUrl.isEmpty else { return item }
            guard let imageWidth = item.imageWidth, imageWidth > 0 else { return item }
            guard let imageHeight = item.imageHeight, imageHeight > 0 else { return item }
            return nil
        }
    }
    
    func checkDuplicate(_ tabList: TabList) -> [Int] {
        let idsStr = """
100540
100541
100542
100543
100544
100545
100546
100547
100548
100549
100550
100552
100553
100554
100556
100557
100559
100560
100561
"""
        let templateIds = idsStr.components(separatedBy: "\n").compactMap { Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) }
        return checkDuplicate(with: templateIds, tabList: tabList)
    }
    
    func checkDuplicate(with templateIds: [Int], tabList: TabList) -> [Int] {
        return templateIds.filter { checkDuplicate(with: $0, tabList: tabList) }
    }
    
    func checkDuplicate(with templateId: Int, tabList: TabList) -> Bool {
        return tabList.allTemplateIds.contains(templateId)
    }
}

private extension TemplateChecker {
    
    struct Constant {
        static let tabFilename = "tab.json"
    }
    
    func loadTab<T: Codable>() async -> T? {
        return DJFileManager.default.loadBundleJSONFile(Constant.tabFilename)
    }
    
}
