import Foundation

let pinController = PinController()
let soundPlayer = SoundPlayer()
let storyController = StoryController()
let rfidController = RFIDController()

while(true) {
    print("Hi and welcome")
    if pinController.isPressingButton() {
        let sound: Sound
        let rfidNumber = rfidController.rfidNumber
        sound = storyController.soundFor(rfid: rfidNumber)
        soundPlayer.play(sound: sound)
        storyController.finishedPlaying()
    }
    Thread.sleep(forTimeInterval: 0.1)
}
