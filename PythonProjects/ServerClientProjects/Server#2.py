import socket
import datetime
import random

LISTEN_PORT = 6000

listening_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM) #creating a scoket

server_address = (socket.gethostname(), LISTEN_PORT) #link the socket to the address
listening_socket.bind(server_address)

listening_socket.listen(1) #only one client can connect at the same time

client_socket, client_address = listening_socket.accept() #waiting for request from the client

def GetHour():
    """
    Returns:
        string: return the current hours, minutes and second
    """
    current_time = datetime.datetime.now()
    return (current_time.strftime("%H:%M:%S"))

def GetDay():
    """
    Returns:
        string: return the current year, month and day
    """
    current_time = datetime.datetime.now()
    return current_time.strftime(f"%Y-%m-%d")

def GetRandom():
    """
    Returns:
        int: return a random number between 1-100 
    """
    return str(random.randint(1,101))

def GetSifratBikoret(id):
    """_summary_
    This function get an id and return the sifrat bikort of the id.

    Returns:
        str: return the sifrat bikort of the id
    """
    
    list = (1,2,1,2,1,2,1,2) 
    sum = 0
    for index in range(0,8):      
        value = int(id[index])*list[index]
        if value > 9:
            value = (value % 10) + (int(value / 10))
        sum += value   
        
    return str(10 - (sum % 10))
    
msg_menu = """Hello dear Client,
Please choose from the next menu :
1. Get current Time
2. Get a random number 1-100
3. Get current date
4. Calc SIFRAT BIKORET
5. Quit""" 

client_socket.sendall(msg_menu.encode()) #send to the client the menu

Is_Quit = False
while(not Is_Quit):
    
    client_msg = client_socket.recv(1024).decode()
    
    if client_msg == "1": #checking if he want the time
        client_socket.sendall(GetHour().encode())

    elif client_msg == "2": #checking if he want a random number between 1-100
        client_socket.sendall(GetRandom().encode())

    elif client_msg == "3": #checking if he want the date
        client_socket.sendall(GetDay().encode())

    elif client_msg == "4": #checking if he want the sifrat bikort
        id = client_socket.recv(1024).decode() #getting the Id from the client
        client_socket.sendall(GetSifratBikoret(id).encode())

    elif client_msg == "5": #checking if he want to Quit
        client_socket.sendall(b"9") #sending him to Quit 
        client_socket.sendall(b"Bye bye client :)") #sending him bye bye 
        
        Is_Quit = True #stopping the loop
    
client_socket.close() 
listening_socket.close()
