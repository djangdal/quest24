import Foundation
import PythonKit
import SwiftyGPIO

let gpios = SwiftyGPIO.GPIOs(for:.RaspberryPi4)
var gp = gpios[.P2]!

gp.onRaising{
    gpio in
    print("Transition to 1, current value:" + String(gpio.value))
}
gp.onFalling{
    gpio in
    print("Transition to 0, current value:" + String(gpio.value))
}
gp.onChange{
    gpio in
    gpio.clearListeners()
    print("The value changed, current value:" + String(gpio.value))
}  

let sys = Python.import("sys")
sys.path.append("Sources/quest/")
let soundPlayer = Python.import("sound")

var isBusy = false

while(true) {
    guard !isBusy else { continue }
    print("Hi and welcome, what do you want to play?")

    if let input = readLine() {
        if input == "1" {
            soundPlayer.play1()
        }
        if input == "2" {
            soundPlayer.play2()
        }
    } else {
        print("Why are you being so coy?")
    }
}
