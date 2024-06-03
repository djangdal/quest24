//
//  PinController.swift
//  quest
//
//  Created by David Jangdal on 2024-06-03.
//

import Foundation
#if os(Linux)
import SwiftyGPIO
#endif

class PinController {
#if os(Linux)
    let pin2: GPIO
#endif
    
    init() {
#if os(Linux)
        let gpios = SwiftyGPIO.GPIOs(for:.RaspberryPi4)
        pin2 = gpios[.P2]!
        pin2.direction = .IN
        
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
    
    func isPressingButton() -> Bool {
#if os(OSX)
        if let input = readLine(), input == "1" {
            return true
        } else {
            return false
        }
#elseif(Linux)
        print("Button value \(pin2.value)")
        return pin2.value == 1
#endif
    }
}
