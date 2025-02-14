//
//  SlotMachineViewModelTests.swift
//  A777SlotMachine
//
//  Created by Anurag Chourasia on 25/05/25.
//

import XCTest
@testable import A777SlotMachine

final class SlotMachineViewModelTests: XCTestCase {

    func testInitialSlotValues() {
        let viewModel = SlotMachineViewModel()
        XCTAssertEqual(viewModel.slot1, "7️⃣")
        XCTAssertEqual(viewModel.slot2, "7️⃣")
        XCTAssertEqual(viewModel.slot3, "7️⃣")
        XCTAssertEqual(viewModel.totalEarning, 0)
    }

    func testSpinSetsIsSpinningTrue() {
        let viewModel = SlotMachineViewModel()
        viewModel.spinSlots()
        XCTAssertTrue(viewModel.isSpinning)
    }

    func testResetSlotsClearsState() {
        let viewModel = SlotMachineViewModel()
        viewModel.totalEarning = 500
        viewModel.spinTapCount = 10
        viewModel.wonAmount = 200
        viewModel.showWinMessage = true
        viewModel.resetSlots()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            XCTAssertEqual(viewModel.totalEarning, 0)
            XCTAssertEqual(viewModel.wonAmount, 0)
            XCTAssertEqual(viewModel.spinTapCount, 0)
            XCTAssertFalse(viewModel.showWinMessage)
        }
    }

    func testCheckWinningCombinationAllMatch() {
        let viewModel = SlotMachineViewModel()
        viewModel.slot1 = "7️⃣"
        viewModel.slot2 = "7️⃣"
        viewModel.slot3 = "7️⃣"
        viewModel.checkWinningCombination()
        XCTAssertEqual(viewModel.wonAmount, 10000)
        XCTAssertEqual(viewModel.totalEarning, 10000)
        XCTAssertTrue(viewModel.showWinMessage)
    }
}
