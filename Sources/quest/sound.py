import pygame
import time

pygame.init()

def play(sound):
    sound = pygame.mixer.Sound('Sounds/'+sound+'.mp3')
    sound.play()
    while(pygame.mixer.get_busy()):
        pygame.time.delay(100)
