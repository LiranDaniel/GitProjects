import socket
import os 

SERVER_IP = socket.gethostname() 
SERVER_PORT = 6000

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM) #creating a socket

server_address = (SERVER_IP, SERVER_PORT) #link to the socket the address
sock.connect(server_address)

menu = sock.recv(1024).decode() #wating from the server to sending the menu
Is_Quit = False

while(not Is_Quit):
    os.system("cls") #clear the terminal
    while True:
        try:       #check if he choosed one of these options
            print(menu)
            option = input("\nEnter Your Choose between 1-5: ")
            if int(option) >=1 and int(option) <=5: break
            else: os.system("cls")
        except:
            os.system("cls")
            print("You Should choose an option")
        
    sock.sendall(option.encode()) #sending him the option that i choosed
    
    if option == "4": #if I choosed the Sifrat Bikoret 
        check_id = False
        id = ""
        while not check_id: #sending him a certified Id
            try:
                id = str(int(input("\nEnter id: ")))
                if len(id) == 8:
                    check_id = True
                else:
                    os.system("cls")
                    print("Enter Correct id: \n")
            except:
                os.system("cls")
                print("Enter Correct id: \n")
        sock.sendall(id.encode())   
          
    msg = sock.recv(1024).decode() #waiting for the answer of the server

    if msg == "9": #if the answer is "9" thats mean that I want to quit and he got the message
        msg = sock.recv(1024).decode() #wating for goodbye from him
        Is_Quit = True #stopping the loop
        break
    
    print(msg)
    input("\nPress Enter To Continue: ")
    
os.system("cls")
print(msg)
sock.close()