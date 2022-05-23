import Foundation

class FuelStationRepository: FuelStationProtocol {
    func getGasPrice(_ completion: @escaping (Double) -> ()) {
        let gasPrice = 7.5
        
        DispatchQueue.main.async {
            completion(gasPrice)
        }
    }
}
