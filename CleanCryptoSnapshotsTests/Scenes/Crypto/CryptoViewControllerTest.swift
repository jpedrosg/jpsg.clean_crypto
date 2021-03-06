//
//  CleanCryptoSnapshotsTests.swift
//  CleanCryptoSnapshotsTests
//
//  Created by João Pedro Giarrante on 04/10/20.
//  Copyright © 2020 Clean Swift LLC. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
@testable import CleanCrypto

class CryptoViewControllerTest: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
//        recordMode = true
    }
    
    func testViewController(){
        
        // launchscreen
        tester().waitForAnimationsToFinish()
        // loadingscreen
        tester().waitForAnimationsToFinish()
        
        
        // Validate first screen
        let imageViewFirstScreen = SnapshotsTestsHelper.getCurrentImageScreen()
        FBSnapshotVerifyView(imageViewFirstScreen, identifier: "first_screen", overallTolerance: 0.1)
    }
}
