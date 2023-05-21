//
//  SettingDictionary+.swift
//  ProjectDescriptionHelpers
//
//  Created by devxsby on 2023/05/21.
//

import ProjectDescription

public extension SettingsDictionary {
    static let allLoadSettings: Self = [
        "OTHER_LDFLAGS" : [
            "$(inherited) -all_load",
            "-Xlinker -interposable"
        ]
    ]
    
    static let baseSettings: Self = [
        "OTHER_LDFLAGS" : [
            "$(inherited)"
        ]
    ]
}
