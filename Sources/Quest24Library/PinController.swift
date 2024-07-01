import Foundation
#if os(Linux)
import SwiftyGPIO
#endif

final public class PinController {
#if os(Linux)
    let pin2: GPIO
#endif
    
    public init() {
#if os(Linux)
        let gpios = SwiftyGPIO.GPIOs(for:.RaspberryPi4)
        pin2 = gpios[.P26]!
        pin2.direction = .IN
        pin2.pull = .down
        
        pin2.onRaising { gpio in
            print("Transition to 1, current value:" + String(gpio.value))
        }
        pin2.onFalling { gpio in
            print("Transition to 0, current value:" + String(gpio.value))
        }
        pin2.onChange { gpio in
            print("The value changed, current value:" + String(gpio.value))
        }
#endif
    }

    public func isPressingButton() -> Bool {
#if os(Linux)
        return pin2.value == 1
#else
        return false
#endif
    }

    public func showLightsFor(level: Level) {
#if os(Linux)
        // Turn on the LED for the level
#endif
    }

    public func showAllRed() {
#if os(Linux)
        // Turn on the LED for the level
#endif
    }
}
