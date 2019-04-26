//
//  EBKAvatarViewExtensions.swift
//  eBay Kleinanzeigen
//
//  Created by Deecke, Roddi on 06.04.16.
//  Copyright © 2016 eBay Kleinanzeigen. All rights reserved.
//

import Foundation

@objc public class InitialsExtractor: NSObject {
    @objc public class func calculateInitialsFromName(_ name: String) -> String {
        let words = name.trimmingCharacters(in: CharacterSet.whitespaces).components(separatedBy: " ").filter { !$0.isEmpty }

        let initials = words.map { (word) in
            word.prefix(1)
        }.map { (initial) in
                initial.capitalized
        }.filter { (initial: String) in
                initial.range(of: "\\A[A-Za-zäëöüÄËÖÜ]$", options: .regularExpression) != nil
        }
        return [initials.first, (initials.count > 1) ? initials.last : nil].compactMap { $0 }.reduce("") { $0 + $1 }
    }
}
