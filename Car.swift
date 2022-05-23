class Car {
    private(set) var isEngineOn = false
    private(set) var currentGear: Gear = .P
    private(set) var isHandbrakeOn = true
    private(set) var isBrakeBeingPressed = false
    private(set) var isSeatBeltFastened = false
    private(set) var fuelLevel = 0.0
    
    private var fuelStation: FuelStationProtocol
    
    init(fuelStation: FuelStationProtocol = FuelStationRepository()) {
        self.fuelStation = fuelStation
    }
    
    var isAlarmBuzzing: Bool {
        return isEngineOn && !isSeatBeltFastened
    }
    var canPlayVideos: Bool {
        return currentGear == .P
    }
    
    func start() {
        if currentGear == .P && isBrakeBeingPressed {
           isEngineOn = true
        }
    }
    
    func shift(to newGear: Gear) {
        self.currentGear = newGear
    }
    
    func brake() {
        self.isBrakeBeingPressed = true
    }
    
    func releaseBrake() {
        self.isBrakeBeingPressed = false
    }
    
    func fuel(quantityInMoney money: Double, _ completion: (() -> ())? = nil) {
        fuelStation.getGasPrice { [weak self] price in
            guard let self = self else { return }
            
            let liters = money / price
            self.fuelLevel += liters
            
            completion?()
        }
    }
}

enum Gear {
    case P
    case R
    case N
    case D
}
