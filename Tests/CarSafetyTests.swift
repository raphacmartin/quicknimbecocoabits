//
//  CarSafetyTests.swift
//  Tests
//
//  Created by Raphael Martin on 5/16/22.
//

import XCTest
import Nimble

class CarSafetyTests: XCTestCase {
    
    override func setUp()  {
        
    }

    override func tearDown() {
        
    }

    func testStart_whenTheShiftIsInPAndBrakeBeingPressedShouldStartTheEngine() {
        // Arrange
        let car = Car()
        car.shift(to: .P)
        car.brake()
        
        // Act
        car.start()
        
        // Assert
        expect(car.isEngineOn).to(beTrue())
        XCTAssert(car.isEngineOn, "Expected the engine to be on")
    }
    
    func testFuel_givenPriceWhenFuelingShouldFuelTheCorrectQuantity() {
        // Arrange
        let quantityInMoney = 50.0
        let fuelStation = MockFuelStation()
        let car = Car(fuelStation: fuelStation)
        let expectedQuantityInLiters = quantityInMoney / fuelStation.gasPrice
        let expectation = expectation(description: #function)
        
        // Act
        car.fuel(quantityInMoney: quantityInMoney) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        // Assert
        XCTAssertEqual(expectedQuantityInLiters, car.fuelLevel)
    }
}
