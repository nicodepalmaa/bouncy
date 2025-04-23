//
//  HighScore.swift
//  bouncy
//
//  Created by Nico on 4/22/25.
//

import SwiftData

@Model
class HighScore {
    var value: Int

    init(value: Int) {
        self.value = value
    }
}
