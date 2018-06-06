//
//  State.swift
//  Loch
//
//  Created by Eric Cormack on 6/5/18.
//  Copyright © 2018 the Odin Spire. All rights reserved.
//

import Foundation

class State {
    static var current = State()

    var isAuthorizedForNotifications = false

    private init() {}
}
