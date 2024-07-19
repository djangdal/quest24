import Foundation
#if os(Linux)
import SwiftyGPIO
#endif

final public class PinController {
    let flashTime = 0.2
#if os(Linux)
    let buttonPin: GPIO
    let level1BluePin: GPIO
    let level1GreenPin: GPIO
    let level2BluePin: GPIO
    let level2GreenPin: GPIO
    let level3BluePin: GPIO
    let level3GreenPin: GPIO
    let level4BluePin: GPIO
    let level4GreenPin: GPIO
    let level5BluePin: GPIO
    let level5GreenPin: GPIO
#endif

    public init() {
#if os(Linux)
        let gpios = SwiftyGPIO.GPIOs(for:.RaspberryPi4)
        buttonPin = gpios[.P17]!
        buttonPin.direction = .IN
        buttonPin.pull = .down

        level1GreenPin = gpios[.P21]!
        level1GreenPin.direction = .OUT
        level1BluePin = gpios[.P20]!
        level1BluePin.direction = .OUT

        level2GreenPin = gpios[.P16]!
        level2GreenPin.direction = .OUT
        level2BluePin = gpios[.P12]!
        level2BluePin.direction = .OUT

        level3GreenPin = gpios[.P7]!
        level3GreenPin.direction = .OUT
        level3BluePin = gpios[.P26]!
        level3BluePin.direction = .OUT

        level4GreenPin = gpios[.P19]!
        level4GreenPin.direction = .OUT
        level4BluePin = gpios[.P13]!
        level4BluePin.direction = .OUT

        level5GreenPin = gpios[.P6]!
        level5GreenPin.direction = .OUT
        level5BluePin = gpios[.P5]!
        level5BluePin.direction = .OUT

        showStartupSequence()
        // pin.onRaising { gpio in
        //     print("Transition to 1, current value:" + String(gpio.value))
        // }
        // pin.onFalling { gpio in
        //     print("Transition to 0, current value:" + String(gpio.value))
        // }
        // pin.onChange { gpio in
        //     print("The value changed, current value:" + String(gpio.value))
        // }
#endif
    }

    public func isPressingButton() -> Bool {
#if os(Linux)
        return buttonPin.value == 1
#else
        return false
#endif
    }

    public func showLightsFor(level: Level) {
#if os(Linux)
        // Turn on the LED for the level
        print("Setting lights for level: \(level.rawValue)")
        allLightsOff()
        switch level {
        case .level1:
            level1BluePin.value = 0
        case .finishedLevel1:
            level1GreenPin.value = 0
        case .level2:
            level1GreenPin.value = 0
            level2BluePin.value = 0
        case .finishedLevel2:
            level1GreenPin.value = 0
            level2GreenPin.value = 0
        case .level3:
            level1GreenPin.value = 0
            level2GreenPin.value = 0
            level3BluePin.value = 0
        case .finishedLevel3:
            level1GreenPin.value = 0
            level2GreenPin.value = 0
            level3GreenPin.value = 0
        case .level4:
            level1GreenPin.value = 0
            level2GreenPin.value = 0
            level3GreenPin.value = 0
            level4BluePin.value = 0
        case .finishedLevel4:
            level1GreenPin.value = 0
            level2GreenPin.value = 0
            level3GreenPin.value = 0
            level4GreenPin.value = 0
        case .level5:
            level1GreenPin.value = 0
            level2GreenPin.value = 0
            level3GreenPin.value = 0
            level4GreenPin.value = 0
            level5BluePin.value = 0
        case .finishedLevel5:
            level1GreenPin.value = 0
            level2GreenPin.value = 0
            level3GreenPin.value = 0
            level4GreenPin.value = 0
            level5GreenPin.value = 0
        case .completed:
            Task {
                allBlue()
                Thread.sleep(forTimeInterval: flashTime)
                allGreen()
                Thread.sleep(forTimeInterval: flashTime)
                allBlue()
                Thread.sleep(forTimeInterval: flashTime)
                allGreen()
                Thread.sleep(forTimeInterval: flashTime)
                allBlue()
                Thread.sleep(forTimeInterval: flashTime)
                allGreen()
                Thread.sleep(forTimeInterval: flashTime)
                allBlue()
                Thread.sleep(forTimeInterval: flashTime)
                allGreen()
                Thread.sleep(forTimeInterval: flashTime)
                allBlue()
                Thread.sleep(forTimeInterval: flashTime)
                allGreen()
                Thread.sleep(forTimeInterval: flashTime)
                allBlue()
                Thread.sleep(forTimeInterval: flashTime)
                allGreen()
                Thread.sleep(forTimeInterval: flashTime)
                allBlue()
                Thread.sleep(forTimeInterval: flashTime)
                allGreen()
            }
        }
#endif
    }

    public func showStartupSequence() {
#if os(Linux)
        allLightsOff()
        level1GreenPin.value = 0
        Thread.sleep(forTimeInterval: flashTime*2)
        allLightsOff()
        level2GreenPin.value = 0
        Thread.sleep(forTimeInterval: flashTime*2)
        allLightsOff()
        level3GreenPin.value = 0
        Thread.sleep(forTimeInterval: flashTime*2)
        allLightsOff()
        level4GreenPin.value = 0
        Thread.sleep(forTimeInterval: flashTime*2)
        allLightsOff()
        level5GreenPin.value = 0
        Thread.sleep(forTimeInterval: flashTime*2)
        allGreen()
        Thread.sleep(forTimeInterval: 2)
        allLightsOff()
#endif
    }

    private func allGreen() {
#if os(Linux)
        allLightsOff()
        level1GreenPin.value = 0
        level2GreenPin.value = 0
        level3GreenPin.value = 0
        level4GreenPin.value = 0
        level5GreenPin.value = 0
#endif
    }

    private func allBlue() {
#if os(Linux)
        allLightsOff()
        level1BluePin.value = 0
        level2BluePin.value = 0
        level3BluePin.value = 0
        level4BluePin.value = 0
        level5BluePin.value = 0
#endif
    }

    public func allLightsOff() {
#if os(Linux)
        level1BluePin.value = 1
        level1GreenPin.value = 1
        level2BluePin.value = 1
        level2GreenPin.value = 1
        level3BluePin.value = 1
        level3GreenPin.value = 1
        level4BluePin.value = 1
        level4GreenPin.value = 1
        level5BluePin.value = 1
        level5GreenPin.value = 1
#endif
    }
}
