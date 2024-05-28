import pygame
from pygame import mixer
import random


# Intialize the pygame
pygame.init()

# create the screen
width = 1680
height = 820
screen_size = (width, height)
window = pygame.display.set_mode(screen_size)

# Display icon
icon = pygame.image.load("Car.png")
pygame.display.set_icon(icon)

# Score
score_value = 0
font = pygame.font.Font('freesansbold.ttf', 32)

# Sound
mixer.music.load("background_sound.wav")
mixer.music.play(-1)

#difine explostion sound
explostion = mixer.Sound("explosion.wav")

# Display caption 
pygame.display.set_caption("Car Game")
    
   
# Load images
BackGround = pygame.image.load("BackGround.png")
lose_screen = pygame.image.load("Loser.png")
carimage = pygame.image.load("Car2.png")
playerimage = pygame.image.load("Car.png") 
Menu = pygame.image.load("Menu.png") 

# Load Buttons
start_button_image = pygame.image.load("StartButton.png")
exit_button_image = pygame.image.load("ExitButton.png")

def Print_image(image,x,y):
    """print image by x and y position

    Args:
        image (object): the loaded image
        x (int): the position of the image that you gonna to pring by x
        y (int): the position of the image that you gonna to pring by y
    """
    window.blit(image, (x,y)) # print the image
    
def Check_click(button_image, position_x, position_y):
    """this function is check if you put yout mouse on the indes of the button and making animation
       and return true or false if you click on the button

    Args:
        button_image (object): image loaded
        position_x (int): position of the button in x 
        position_y (int): position of the button in y

    Returns:
        bool: return bool if click on the button else false
    """
    IsClick = False
    rect = button_image.get_rect() # getting width and height 
    rect.topleft = (position_x,position_y) # difine the position 
    
    pos = pygame.mouse.get_pos() # Getting the mouse postion by x and y
    
    if rect.collidepoint(pos): #check if the mouse was on the area of the button
        window.blit(button_image,(position_x-1,position_y-1)) # if he was the doing animation 
        if pygame.mouse.get_pressed()[0] ==1: # and if he clicked the button then it return true
             IsClick = True
             
    # else return false         
    return IsClick

def show_score(score_value):
    """
    this function is print the socre and the top left of the screen
    """
    score = font.render("Score : " + str(score_value), True, (255, 255, 255)) 
    window.blit(score, (20, 20))



def main(): 
    """
    this function is running the game
    Returns:
        nothing
    """
    # Difine Fps
    clock = pygame.time.Clock()
    FPS = 60
    
    # buttons positions
    exit_button_position_x = (width/2) - (carimage.get_rect()[2] /2)
    exit_button_position_y = height/3*2 - (carimage.get_rect()[3] /2)
    exit_button_positions = (exit_button_position_x, exit_button_position_y)
    
    start_button_position_x = (width/2) - (carimage.get_rect()[2] /2)
    start_button_position_y = 100
    start_button_positions = (start_button_position_x,start_button_position_y)
   
    # score value
    score_value = 0

    # options of placement
    player_car_y_option_1 = 600
    player_car_y_option_2 = 690
    
    player_current_x = 780
    player_current_y = player_car_y_option_1
    
    # options of placment for second car
    car_y_option_1 = 630
    car_y_option_2 = 720
    
    car_current_x = 0
    car_current_y = car_y_option_2 
      
    # Speed of the second car
    SPEED = 30
    
    # bolians Veriable for Screen loops
    running = True
    IsStart = False
    lose = False
  
    while running:
        # displat fps 
        clock.tick(FPS)
        
        if lose: #show lose screen if lose
            for event in pygame.event.get(): # Checks if he is tring to close the window
                if event.type == pygame.QUIT:
                    running = False
                if event.type == pygame.KEYDOWN: # Check if he is want to return to the menu
                    if event.key == pygame.K_ESCAPE:
                        lose = False
                        IsStart = False
            window.blit(lose_screen,(0,0)) # print the loser screen
            
        elif not IsStart: #show menu 
            for event in pygame.event.get(): # Checks if he is tring to close the window
                if event.type == pygame.QUIT:
                    running = False
            window.blit(Menu, (0,0)) # Print menu screen
            window.blit(start_button_image, start_button_positions) #print button Start
            window.blit(exit_button_image, exit_button_positions)   #print button Exit 
            
            if Check_click(start_button_image, start_button_position_x, start_button_position_y): #Check if he has been clicked the start button
                IsStart = True
            elif Check_click(exit_button_image, exit_button_position_x, exit_button_position_y): #Check if he has been clicked the exit button
                running = False
                
            pygame.display.update()
            
            # Reset the veriable positions and score
            car_current_x = 0
            car_current_y = 630
            
            player_current_x = 780
            player_current_y = 600
            
            score_value = 0
            
        else:     # the game if he is selected the Start button
            for event in pygame.event.get(): # Checks if he is tring to close the window
                if event.type == pygame.QUIT:
                    running = False
                if event.type == pygame.KEYDOWN: #Check which keybind he is pressed
                    if event.key == pygame.K_UP:
                        player_current_y = player_car_y_option_1
                    if event.key == pygame.K_DOWN:
                        player_current_y = player_car_y_option_2
                    if event.key == pygame.K_ESCAPE:
                        IsStart = False
            
            # if colosion with the screen return to the beginning
            if car_current_x >= 1680:
                select_position = random.randint(1,2) #random position between 2 options
                if select_position == 1: #select first option
                    car_current_y = car_y_option_1
                else: #select second option
                    car_current_y = car_y_option_2
                car_current_x = 0 #return the the beginning
                score_value += 1 #increase the score by one 
            
            
            if car_current_x + 230 >= 780 and car_current_x <= 1010: # Check if there is collistion between the both cars
                if car_current_y == car_y_option_1 and player_current_y == player_car_y_option_1:
                    lose = True
                    explostion.play() #making explostion sound
                     
                if car_current_y == car_y_option_2 and player_current_y == player_car_y_option_2:
                    lose = True
                    explostion.play()

                    
            car_current_x += SPEED #move the car by increase the x position every time
            
            #print the background
            window.blit(BackGround,(0,0))    
                      
            #print second car
            Print_image(carimage,car_current_x,car_current_y)
            
            #print player  
            Print_image(playerimage,player_current_x,player_current_y)
            
            #print the score on the top of the screen
            show_score(score_value)
            
        #update the screen every time
        pygame.display.update()
        
    # quiting py game
    pygame.quit()
     
# check if you are running the file
# if true run the code
# ELSE GIVE YOU THE FUNCTION AND SOME OF VERIABLES
if __name__ == "__main__":
    main()