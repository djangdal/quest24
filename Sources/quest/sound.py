import pygame
import time
# from playsound import playsound

pygame.init()

def play():
    sound = pygame.mixer.Sound('/home/djangdal/quest24/1.mp3')
    sound.play()
    while(pygame.mixer.get_busy()):
        pygame.time.delay(100)
    # return sound.get_length()
    
    # playsound('/home/djangdal/quest24/1.mp3')
    # sound.play()
    # return sound.get_length()

def hello():
    return "Hey swift"