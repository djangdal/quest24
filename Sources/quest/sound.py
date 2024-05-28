import pygame
import time
# from playsound import playsound

pygame.init()

def play1():
    sound = pygame.mixer.Sound('1.mp3')
    sound.play()
    while(pygame.mixer.get_busy()):
        pygame.time.delay(100)

def play2():
    sound = pygame.mixer.Sound('2.mp3')
    sound.play()
    while(pygame.mixer.get_busy()):
        pygame.time.delay(100)
