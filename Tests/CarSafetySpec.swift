import Quick
import Nimble
class CarSafetySpec: QuickSpec {
    override func spec() {
        // Arrange
        var car: Car!
        beforeEach {
            car = Car()
        }
        
        
        describe("Pressing the start button") {
            context("when the shift is in the P position") {
                context("when the brake pedal is being pressed") {
                    it("the car should start the engine") {
                        // Arrange
                        car.shift(to: .P)
                        car.brake()
                        
                        // Act
                        car.start()
                        
                        // Assert
                        expect(car.isEngineOn).to(beTrue())
                    }
                }
            }
            
            context("when the shift is not in the P position") {
                // Arrange
                beforeEach { car.shift(to: .D) }
                it("the car should not start the engine") {
                    // Act
                    car.start()
                    
                    // Assert
                    expect(car.isEngineOn).to(beFalse())
                }
                
                context("when the brake pedal is not being pressed") {
                    // Arrange
                    beforeEach { car.releaseBrake() }
                    
                    it("the car should not start the engine") {
                        // Act
                        car.start()
                        
                        // Assert
                        expect(car.isEngineOn).to(beFalse())
                    }
                }
            }
        }
        
        describe("Fueling the car") {
            context("With specific gas price") {
                it("Should fill the correct quantity") {
                    // Arrange
                    let quantityInMoney = 50.0
                    let fuelStation = MockFuelStation()
                    let car = Car(fuelStation: fuelStation)
                    let expectedQuantityInLiters = quantityInMoney / fuelStation.gasPrice
                    
                    // Act
                    car.fuel(quantityInMoney: quantityInMoney)
                    
                    // Assert
                    expect(car.fuelLevel).toEventually(equal(expectedQuantityInLiters))
                    expect(car.fuelLevel).toNever(beGreaterThan(expectedQuantityInLiters))
                }
            }
        }
        
    }
}
