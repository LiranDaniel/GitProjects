import socket

LISTEN_PORT = 80

listening_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_address = (socket.gethostname(), LISTEN_PORT)
listening_socket.bind(server_address)

listening_socket.listen(1)

client_socket, client_address = listening_socket.accept()

client_msg = client_socket.recv(1024).decode().upper()
client_socket.sendall(client_msg.encode())


client_socket.close()
listening_socket.close()