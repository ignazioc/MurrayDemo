//
// Created by Plunien, Johannes on 28.02.19.
// Copyright © 2019 eBay Kleinanzeigen. All rights reserved.
//

import Foundation

public protocol EBKEmptyStateContentProtocol {

    var title: String? { get set }
    var message: String? { get set }
    var image: UIImage? { get set }
    var buttonTitle: String? { get set }

    var buttonHandler: (() -> Void)? { get set }

}
