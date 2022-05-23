import Foundation

class MockFuelStation: FuelStationProtocol {
    let gasPrice = 7.5
    
    func getGasPrice(_ completion: @escaping (Double) -> ()) {
        DispatchQueue.main.async {
            completion(self.gasPrice)
        }
    }
}
