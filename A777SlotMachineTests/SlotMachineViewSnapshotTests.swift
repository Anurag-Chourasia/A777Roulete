//
//  SlotMachineViewSnapshotTests.swift
//  A777SlotMachine
//
//  Created by Anurag Chourasia on 25/05/25.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import A777SlotMachine

class SlotMachineViewSnapshotTests: XCTestCase {

    //MARK: - Snapshot Tests Across Modes, Fonts, Devices

    func testSlotMachineView_iPhones_AllConfigurations() {
        let modes: [(ColorScheme, String)] = [(.light, "Light"), (.dark, "Dark")]
        let sizes: [(DynamicTypeSize, String)] = [(.xSmall, "SmallFont"), (.xxLarge, "XXLargeFont"), (.accessibility5, "LargestFont")]
        let devices: [(CGSize, String)] = [(CGSize(width: 375, height: 667), "iPhoneSE2"), (CGSize(width: 430, height: 932), "iPhone16ProMax")]

        for (scheme, schemeName) in modes {
            for (size, sizeName) in sizes {
                for (deviceSize, deviceName) in devices {
                    let view = SlotMachineView()
                        .environment(\.colorScheme, scheme)
                        .environment(\.dynamicTypeSize, min(size, .xxxLarge))
                    let name = "\(schemeName)_\(sizeName)_\(deviceName)"
                    assertSnapshot(
                        of: view,
                        as: .image(layout: .fixed(width: deviceSize.width, height: deviceSize.height)),
                        named: name
                    )
                }
            }
        }
    }

    func testSlotMachineView_iPads_AllConfigurations() {
        let modes: [(ColorScheme, String)] = [(.light, "Light"), (.dark, "Dark")]
        let sizes: [(DynamicTypeSize, String)] = [(.xSmall, "SmallFont"), (.xxLarge, "XXLargeFont"), (.accessibility5, "LargestFont")]
        let devices: [(CGSize, String)] = [(CGSize(width: 744, height: 1133), "iPadMini"), (CGSize(width: 820, height: 1180), "iPad10thGen")]

        for (scheme, schemeName) in modes {
            for (size, sizeName) in sizes {
                for (deviceSize, deviceName) in devices {
                    let view = SlotMachineView()
                        .environment(\.colorScheme, scheme)
                        .environment(\.dynamicTypeSize, min(size, .xxxLarge))
                    let name = "\(schemeName)_\(sizeName)_\(deviceName)"
                    assertSnapshot(
                        of: view,
                        as: .image(layout: .fixed(width: deviceSize.width, height: deviceSize.height)),
                        named: name
                    )
                }
            }
        }
    }
}
