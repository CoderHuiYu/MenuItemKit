//
//  UIMenuItem.swift
//  MenuItemKit
//
//  Created by CHEN Xian’an on 1/16/16.
//  Copyright © 2016 lazyapps. All rights reserved.
//

import UIKit
import ObjectiveC.runtime
#if !NON_SPM
@_exported import ObjCSwizzlings
#endif

public extension UIMenuItem {
    @objc(mik_initWithTitle:image:tintColor:action:)
    convenience init(title: String, image: UIImage?, tintColor: UIColor?=nil, action: @escaping MenuItemAction) {
        let title = image != nil ? title + imageItemIdetifier : title
        self.init(title: title, action: Selector(blockIdentifierPrefix + UUID.stripedString + ":"))
        imageBox.value = image
        tintColorBox.value = tintColor
        actionBox.value = action
    }

  @objc(mik_initWithTitle:action:)
  convenience init(title: String, action: @escaping MenuItemAction) {
    self.init(title: title, image: nil, action: action)
  }

  @objc(mik_isMenuItemKitSelector:)
  static func isMenuItemKitSelector(_ sel: Selector) -> Bool {
    return NSStringFromSelector(sel).hasPrefix(blockIdentifierPrefix)
  }
}

// MARK: NSUUID
private extension UUID {
  static var stripedString: String {
    return UUID().uuidString.replacingOccurrences(of: "-", with: "_")
  }
}
