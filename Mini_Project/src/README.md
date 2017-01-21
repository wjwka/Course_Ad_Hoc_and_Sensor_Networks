# Instruction
This page shows how to run the whole program.

# Sensing
## Start Ppp Router
> $ cd PppRouter
> $ make telosb install

## Start sampling:
> $ cd Sensing/utils/
> $ make telosb install,2 bsl,/dev/ttyUSB1
> $ python streaming.py

# Server
## Start the server:
> $ cd Server/
> $ export FLASK_APP = server.py
> $ flask run

## Access the controler page using the address:
> 127.0.0.1:2000

## Access the data page using:
> 127.0.0.1:2000/data
