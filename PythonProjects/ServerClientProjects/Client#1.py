import socket

SERVER_PORT = 80
IP_ADDRESS = socket.gethostname()

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_address = (IP_ADDRESS, SERVER_PORT)
sock.connect(server_address)

string_msg = "i love pizza"
sock.sendall(string_msg.encode())

server_msg = sock.recv(1024).decode()
print(server_msg)

sock.close()