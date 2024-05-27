import Foundation
import PythonKit
//import SwiftyGPIO

//let gpios = SwiftyGPIO.GPIOs(for:.RaspberryPi4)
//var gp = gpios[.P2]!

print("helloo")

let sys = Python.import("sys")
sys.path.append("/home/djangdal/quest24/Sources/quest/")
let example = Python.import("sound")
let response = example.hello()
print(response)
let length = example.play()
print("Don3 \(length)")
// guard let soundFi{leURL = Bundle.main.url(
//     forResource: "1", withExtension: "mp3"
// ) else {
//     throw SoundError.fileNotFound
// }}
// let task = Process()
// task.executableURL = URL(fileURLWithPath: "/usr/bin/mpg321")
// let filename = "1.mp3"
// task.arguments = [filename]
// //task.waitUntilExit()
// Task {
// task.terminationHandler = { process in
// print("did finish")
// }
// try task.run()
// }

var i = 0
while(i < 9) {
    print("Hello")
    usleep(1000000)
    i += 1
}