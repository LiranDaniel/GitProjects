;------------------------------------------
; PURPOSE : Fire Boy And Water Girl 
; SYSTEM  : Turbo Assembler Ideal Mode  
; AUTHOR  : Liran Daniel 
; TEACHER : Anatoliy peymer
; class : yod 1
;------------------------------------------
.386

		IDEAL
		
		jumps
		
		MODEL small			
		
		;----------------------------------Fire Boy:
		MACRO MDrawBOY StartX, StartY, ImgBoy ;DrawBoy by x and y 
         mov ax,[StartX]
         mov [BOYcurrent_X],ax
         mov ax, [StartY]
         mov [BOYcurrent_Y], ax

         mov si, offset ImgBoy
         call PDrawBOY
        ENDM MDrawBOY
		
		;----------------------------------Water Girl:
		MACRO MDrawGIRL StartX, StartY, ImgGIRL ;DrawGirl by x and y
         mov ax,[StartX]
         mov [GIRLcurrent_X],ax
         mov ax, [StartY]
         mov [GIRLcurrent_Y], ax
  
         mov si, offset ImgGIRL
         call PDrawGIRL
        ENDM MDrawGIRL
			
	;/*//**/*/*/*//*/***********************************************************
    ;/*//**/*/*/*//*/***********************************************************::::::::::::::::::::::::::::::::::::CHECK MOVMENT BLOCKS::::::	

      MACRO CheckLeftRight X,Y,Ysize        
	  LOCAL LREND,NoMovingLR,BloockRedLR,BloockBlueLR,CheckLR,FirstCheckLR,DoorBlueLR,DoorRedLR,CheckBloockRedLR,CheckBloocBlueLR,DoorLR,CheckDoorLR,FirstCheckL
	  mov si,0
	  jmp FirstCheckL
	  
NoMovingLR:
      mov si,1
	  jmp LREND
	  
BloockRedLR:
      cmp si,2
	  je LREND
	  
	  cmp si,0
	  jne NoMovingLR
	  
	  mov si,2
	  jmp LREND

CheckBloockRedLR:
      mov si,2
	  jmp CheckLR
	  
BloockBlueLR:
      cmp si,3
	  je LREND
	  
	  cmp si,0
	  jne NoMovingLR
	  
	  mov si,3
	  jmp LREND

CheckBloocBlueLR:
      mov si,3
	  jmp CheckLR
	  
DoorLR:
      cmp si,4
	  je LREND
	  
	  cmp si,0
	  jne NoMovingLR
	  
	  mov si,4
	  jmp LREND

	  
CheckDoorLR:
      mov si,4
	  jmp CheckLR
	  
FirstCheckL:
;Read pixel color
      mov cx,[x]
	  mov dx,[y]
	  mov ah,0dh
	  int 10h
	  
	  ;Check Blocks
	  cmp al,15
	  je NoMovingLR
	  
	  cmp al,04
	  je CheckBloockRedLR
	  
	  cmp al,11
	  je CheckBloocBlueLR
	  
	  cmp al,7
	  je CheckDoorLR
	  
CheckLR:
;Read pixel color
      mov cx,[x]
	  mov dx,[y]
	  add dx,Ysize
	  mov ah,0dh
	  int 10h
	  
      ;Check Blocks
	  cmp al,15
	  je NoMovingLR
	  
	  cmp al,04
	  je BloockRedLR
	  
	  cmp al,11
	  je BloockBlueLR
	  
	  cmp al,7
	  je DoorLR

LREND: 
      push si
	  
	  ENDM CheckLeftRight
;*************************************************************************************************************************
;*************************************************************************************************************************
;Check Left and Right Block color and return into si the number of the Block colors
;InPut: Y , X ,Ysize
;OutPut push si
;*************************************************************************************************************************
;*************************************************************************************************************************
	 
	  MACRO CheckUpDown Y,X,Xsize
	  LOCAL UDEND,NoMovingUD,BloockRedUD,BloockBlueUD,CheckUD,FirstCheckUD,DoorBlueUD,DoorRedUD,CheckBloockRedUD,CheckBloocBlueUD,DoorUD,CheckDoorUD
	  mov si,0
	  jmp FirstCheckUD
	  
NoMovingUD:
      mov si,1
	  jmp UDEND
	  
BloockRedUD:
      cmp si,2
	  je UDEND
	  
	  cmp si,0
	  jne NoMovingUD
	  
	  mov si,2
	  jmp UDEND

CheckBloockRedUD:
      mov si,2
	  jmp CheckUD
	  
BloockBlueUD:
      cmp si,3
	  je UDEND
	  
	  cmp si,0
	  jne NoMovingUD
	  
	  mov si,3
	  jmp UDEND

CheckBloocBlueUD:
      mov si,3
	  jmp CheckUD
	  
DoorUD:
      cmp si,4
	  je UDEND
	  
	  cmp si,0
	  jne NoMovingUD
	  
	  mov si,4
	  jmp UDEND

	  
CheckDoorUD:
      mov si,4
	  jmp CheckUD
	  
FirstCheckUD:
;Read pixel color
      mov cx,[x]
	  mov dx,[y]
	  mov ah,0dh
	  int 10h
	  
	  ;CheckBlocks
	  cmp al,15
	  je NoMovingUD
	  
	  cmp al,04
	  je CheckBloockRedUD
	  
	  cmp al,11
	  je CheckBloocBlueUD
	  
	  cmp al,7
	  je CheckDoorUD
	  
CheckUD:
      ;Read pixel color
      mov cx,[x]
	  add cx, Xsize
	  mov dx,[y]
	  mov ah,0dh
	  int 10h
	  
	  ;CheckBlocks
	  cmp al,15
	  je NoMovingUD
	  
	  cmp al,04
	  je BloockRedUD
	  
	  cmp al,11
	  je BloockBlueUD
	  
	  cmp al,7
	  je DoorUD

UDEND: 
      push si
	  
	  ENDM CheckLeftRight
	  
;*************************************************************************************************************************
;*************************************************************************************************************************
;Check Up and Down Block color and return into si the number of the Block colors
;InPut: Y , X ,Xsize
;OutPut push si
;registers ax,dx,cx,si
;*************************************************************************************************************************
;*************************************************************************************************************************
	 
	 
;/*//**/*/*/*//*/***********************************************************::::::::::::::::::::::::::::::::::::::::::	
;/*//**/*/*/*//*/***********************************************************::::::::::::::::::::::::::::::::::::::::::	

	

		STACK 256

		;Fire Boy Keys:
		KEY_RIGHT equ 77
		KEY_LEFT equ 75 
		KEY_DOWN equ 80
		KEY_UP equ 72
		
		
		;Water girl Keys
		Key_D equ 32
		KEY_A equ 30
		KEY_W equ 17
		KEY_S equ 31
		
		
		Key_Esc equ 1
		Key_q equ 15		
		
		
;----- 	Equates
;/*//**/*/*/*//*/***********************************************************::::::::::::::::::::::::::::::::::::::::::DATA SEGMENT:::::::::::::::::::::

		DATASEG
		include "BitMGame.inc"		
				
				
		start_maze_x  dw 0
		start_maze_y dw 0

        x_BitMap dw ?
        y_BitMap dw ?
		temp_x  dw ?
		temp_y  dw ?		
		check dw ?
				 		
;FireBoy:			 
		  BOYimg db 000,000,000,000,000,000,000,000,000,000,000,000
        		 db 000,000,000,000,000,004,000,000,000,000,000,000
                 db 000,000,000,000,000,004,000,000,000,004,000,000
                 db 000,004,000,000,000,004,000,000,000,004,000,000
                 db 000,004,004,000,004,004,000,000,004,004,004,000
                 db 000,004,004,004,004,004,004,004,004,004,004,000
                 db 000,004,014,014,014,004,004,014,043,043,004,000
                 db 000,004,043,016,014,004,004,014,000,043,004,000
				 db 000,004,043,043,014,004,004,014,014,014,004,000
				 db 000,004,004,004,004,004,004,004,004,004,004,000
				 db 000,004,004,000,004,004,004,004,004,004,004,000
				 db 000,000,004,004,000,000,000,004,004,004,000,000
				 db 000,000,000,004,004,004,004,004,004,000,000,000
				 db 000,000,000,000,000,000,000,000,000,000,000,000
				 db 000,000,000,004,004,004,004,004,004,000,000,000
				 db 000,000,004,004,004,004,004,004,004,004,000,000
				 db 000,000,004,000,004,004,004,004,000,004,000,000
				 db 000,000,000,000,004,004,004,004,000,000,000,000
				 db 000,000,000,000,004,004,004,004,000,000,000,000
				 db 000,000,000,000,004,000,004,004,000,000,000,000
				 db 000,000,000,000,004,000,000,004,000,000,000,000
				 db 000,000,000,000,111,000,000,004,000,000,000,000
				 db 000,000,000,000,111,000,000,004,000,000,000,000
				 db 000,000,000,000,111,000,000,004,000,000,000,000
				 db 000,000,000,000,000,000,000,000,000,000,000,000

                  BOYtemp_array db 25*12 dup(0)
			 
	              w_BOYimg      dw 12
                  h_BOYimg      dw 25
                  BOYStartPictX dw 200
                  BOYStartPictY dw 160

                  BOYcurrent_x   dw ?
                  BOYcurrent_y   dw ?
                  BOYis_restore  db ?
				  
;Water Girl:
          GIRLimg db 000,000,000,000,000,000,000,000,000,000,000,000,000,000,000
		          db 000,000,000,000,053,053,053,053,053,053,000,000,000,000,000
                  db 000,000,000,000,052,000,052,052,000,052,000,000,000,000,000
                  db 000,000,000,000,000,000,052,053,000,000,000,000,000,000,000
                  db 000,000,000,053,053,000,053,000,053,053,052,000,000,000,000
                  db 000,053,052,053,053,053,000,053,053,052,052,053,000,000,000
                  db 000,000,000,052,053,000,053,000,000,052,053,053,052,000,000
                  db 000,000,052,000,000,053,053,053,053,000,000,000,052,000,000
				  db 000,053,011,052,052,052,053,053,052,052,052,053,000,053,000
				  db 000,053,053,052,000,052,053,053,052,000,052,053,000,053,000
				  db 000,053,053,052,052,052,053,053,052,052,052,053,000,000,000
				  db 000,053,053,053,053,053,053,053,053,053,053,053,000,000,000
				  db 000,000,053,053,053,052,053,053,000,053,053,053,000,000,000
				  db 000,000,000,053,053,053,000,000,000,011,053,000,000,000,000
				  db 000,000,000,000,053,053,053,053,011,011,000,000,000,000,000
				  db 000,000,000,000,000,000,000,000,000,000,000,000,000,000,000
				  db 000,000,000,000,053,053,053,053,053,053,000,000,000,000,000
				  db 000,000,000,053,053,053,053,053,053,053,053,000,000,000,000
				  db 000,000,000,053,000,053,053,053,053,000,053,000,000,000,000
				  db 000,000,000,000,000,053,053,053,054,000,000,000,000,000,000
				  db 000,000,000,000,000,053,053,054,054,000,000,000,000,000,000
				  db 000,000,000,000,000,053,054,055,055,000,000,000,000,000,000
				  db 000,000,000,000,000,054,000,055,055,000,000,000,000,000,000
				  db 000,000,000,000,000,055,000,000,055,000,000,000,000,000,000
				  db 000,000,000,000,000,055,000,000,055,000,000,000,000,000,000
				  db 000,000,000,000,000,055,000,000,055,000,000,000,000,000,000
				  db 000,000,000,000,000,000,000,000,000,000,000,000,000,000,000
				  
     			  GIRLtemp_array db 27*15 dup(0)
			 
	              w_GIRLimg      dw 15
                  h_GIRLimg      dw 27
                  GIRLStartPictX dw 40
                  GIRLStartPictY dw 10

                  GIRLcurrent_x   dw ?
                  GIRLcurrent_y   dw ?
                  GIRLis_restore  db ?			  
				  
;-------------------------------------------------------------------------------		
;///////////////////Pcx Pic Files / Stats:
		  		
				  StartPictX   dw ?
                  StartPictY   dw ?
                  WidthPict    dw ?
                  HeightPict   dw ?
                  LengthPict   dw ?
                  Handle       dw 0
                  FileLength   dw ?
                  FileMenu     db 'Menu.pcx',0
                  FileHelp     db 'Help.pcx',0
				  FileGirl     db 'GirlWon.pcx',0
				  FileBoy      db 'BoyWon.pcx',0

                  Buffer       db 50000 dup(?)
                  Point_Buffer dd Buffer
                  Point_Fname  dd ?             ; FileName
                  x            dw ?
                  y            dw ?
                  color        db ?

;-------------------------------------------------------------------------------				  
				  
				  key  db ?
				  Mkey db ?   
                
		CODESEG
          
Start:
        mov ax, @data
        mov ds, ax
			
menuL:       
        call main 
MkeyCheck:		
		mov ah,00h ;read key press
		int 16h 
		mov [Mkey], al		;Check Choose
	
		cmp [Mkey],' '
		je HelpL
		
		cmp [Mkey],13d
		je GameL
		
		cmp [Mkey],'q'
		je Exit
		
		jmp MkeyCheck

HelpL: 
        call PHelp   ;Draw Help and Check ESC key
		
HelpCheck:		
        mov ah,00h
		int 16h
		cmp al,27d
		je menuL
		Jmp HelpCheck
 	
GameL: 	                                
       call cls 
	 
;Reset the variables
	   mov [BOYStartPictX], 200
       mov [BOYStartPictY], 160
	   mov [GIRLStartPictX], 40
       mov [GIRLStartPictY], 10

   	   call DrawMaze  ;Draw The BackGround OF The Game

MainLoop:	 
;-------Draw ImgBoy:
	   MDrawBOY BOYStartPictX, BOYStartPictY, BOYimg ;Draw Fire Boy
	   
	   MDrawGIRL GirlStartPictX, GirlStartPictY, Girlimg ;Draw Water Girl 
	
;-------Read Scan Code From Keyboard:
	in al,060h
    mov [key], al
    je no_moving

no_moving:		 
;------------------------------:	
;Check Key Press
	   cmp [key], Key_Esc
	   je menuL	      

   	   cmp [key],KEY_UP
       je Up 
	   
	   cmp [key],KEY_DOWN
	   je Down
	   
	   cmp [key],KEY_RIGHT
	   je Right
	   
	   cmp [key],KEY_LEFT
	   je Left
	   
       cmp [key], KEY_W
       je W

       cmp [key], KEY_S
       je S
      
       cmp [key], KEY_D
       je D

       cmp [key], KEY_A
       je A	   	  
 	  
	  jmp MainLoop
	  
;------------------------**********************::::::::::	  
;Check if can Go Up By blocks Color
UpCheck:
      inc [BOYStartPictY]
	  
	  cmp si,4
	  je BoyWon
	  
	  jmp MainLoop
		
Up:   dec [BOYStartPictY] 
	  CheckUpDown BOYStartPictY,BOYStartPictX,12

	  pop si
	  cmp si,1
	  je UpCheck
	  
	  cmp si,3
	  je UpCheck
	  
	  cmp si,4
	  je UpCheck	  	  
	  
	  jmp MainLoop
;----------------------
;Check if can Go Up By blocks Color
WCheck:
      inc [GirlStartPictY]
	  
	  cmp si,4
	  je GirlWon
	  
	  jmp MainLoop
	  	  
W:    dec [GIRLStartPictY] 
	  CheckUpDown GIRLStartPictY,GirlStartPictX,15
	  
	  pop si
	  cmp si,1
	  je WCheck
	  
	  cmp si,2
	  je WCheck
	  
	  cmp si,4
	  je WCheck	  
	  
	  jmp MainLoop

;----------------------	
;Check if can Go Down By blocks Color
Downcheck:
      dec [BOYStartPictY]
	  
	  cmp si,4
	  je BoyWon
	 
	  jmp MainLoop	  
	
Down: inc [BOYStartPictY]
      add [BOYStartPictY],25
	  CheckUpDown BOYStartPictY,BOYStartPictX,12
      sub [BOYStartPictY],25

	  pop si
	  cmp si,1
	  je Downcheck
	  
	  cmp si,3
	  je Downcheck
	  	
	  cmp si,4
	  je Downcheck
	  
	  jmp MainLoop
	  
;----------------------	
;Check if can Go Down By blocks Color
Scheck:
      dec [GIRLStartPictY]
	  
	  cmp si,4
	  je GirlWon
	  
	  jmp MainLoop

S:    inc [GIRLStartPictY]
      add [GIRLStartPictY],27
	  CheckUpDown GIRLStartPictY,GirlStartPictX,15
      sub [GIRLStartPictY],27
	  
	  pop si
      cmp si,1
	  je Scheck
	  
	  cmp si,2
	  je Scheck
	  
	  cmp si,4
	  je Scheck	  
  
	  jmp MainLoop

;----------------------	
;Check if can Go Right By blocks Color
Rightcheck:
      dec [BOYStartPictX]
	  
	  cmp si,4
	  je BoyWon	  
	  
      jmp MainLoop

 

Right:inc [BOYStartPictX]
	  add [BOYStartPictX],12
	  CheckLeftRight BOYStartPictX,BOYStartPictY,25
	  sub [BOYStartPictX],12

	  pop si
	  cmp si,1
	  je Rightcheck
	  
	  cmp si,3
	  je Rightcheck
	  
	  cmp si,4
	  je Rightcheck
	  
	  ;Check Extra Colors Because The High oF The blocks
	  add [BOYStartPictX],12
	  add [BOYStartPictY],8
	  CheckLeftRight BOYStartPictX,BOYStartPictY,9
	  sub [BOYStartPictX],12
	  sub [BOYStartPictY],8
	  	  
	  
	  pop si
	  cmp si,1
	  je Rightcheck
	  
	  cmp si,3
	  je Rightcheck
	  
	  cmp si,4
	  je Rightcheck
  
	  jmp MainLoop
	  
;----------------------	
;Check if can Go Right By blocks Color
Dcheck: 
      dec [GirlStartPictX]
	  
	  cmp si,4
	  je GirlWon
	  
      jmp MainLoop
 
D:    inc [GirlStartPictX]
	  add [GirlStartPictX],15
	  CheckLeftRight GirlStartPictX,GIRLStartPictY,27
	  sub [GirlStartPictX],15
	  
	  pop si
      cmp si,1
	  je Dcheck
	  
	  cmp si,2
	  je Dcheck
	  
	  cmp si,4
	  je Dcheck
	  
	  ;Check Extra Colors Because The High oF The blocks  
	  add [GirlStartPictX],15
	  add [GIRLStartPictY],9
	  CheckLeftRight GirlStartPictX,GIRLStartPictY,9
	  sub [GirlStartPictX],15
	  sub [GIRLStartPictY],9
	  
	  pop si
      cmp si,1
	  je Dcheck
	  
	  cmp si,2
	  je Dcheck
	  
	  cmp si,4
	  je Dcheck
	  
	  
	  jmp MainLoop

;----------------------	
;Check if can Go Left By blocks Color
Leftcheck:
      inc [BOYStartPictX]
	  
	  cmp si,4
	  je BoyWon
	  
      jmp MainLoop 
	
Left: dec [BOYStartPictX]
	  CheckLeftRight BOYStartPictX,BOYStartPictY,25
	  
	  pop si
	  cmp si,1
	  je Leftcheck
	  
	  cmp si,3
	  je Leftcheck
	  
	  cmp si,4
	  je Leftcheck
	  
	  ;Check Extra Colors Because The High oF The blocks	   
	  add [BOYStartPictY],8
	  CheckLeftRight BOYStartPictX,BOYStartPictY,9
	  sub [BOYStartPictY],8

	  pop si
	  cmp si,1
	  je Leftcheck
	  
	  cmp si,3
	  je Leftcheck
	  
	  cmp si,4
	  je Leftcheck
	   
	  jmp MainLoop

;----------------------	
;Check if can Go Left By blocks Color
Acheck:
      inc [GIRLStartPictX]
	  
	  cmp si,4
	  je GirlWon

      jmp MainLoop 
	  
A:    dec [GIRLStartPictX]
	  CheckLeftRight GirlStartPictX,GIRLStartPictY,27
	  
	  pop si
      cmp si,1
	  je Acheck
	  
	  cmp si,2
	  je Acheck
	  
	  cmp si,4
	  je Acheck
	  
	  ;Check Extra Colors Because The High oF The blocks  
	  add [GIRLStartPictY],9
	  CheckLeftRight GirlStartPictX,GIRLStartPictY,9
	  sub [GIRLStartPictY],9

	  pop si
      cmp si,1
	  je Acheck
	  
	  cmp si,2
	  je Acheck
	  
	  cmp si,4
	  je Acheck
	    
	  jmp MainLoop

;Draw Boy won Proc 
BoyWon:
       Call cls 
	  
	   mov [StartPictX],0d
       mov [StartPictY],0d

       mov [word Point_Fname],offset FileBoy
       mov [word Point_Fname+2],seg FileBoy 

       call drawPCX
	   
;Check Key Press
CheckBoyWon:	   
       mov ah,00h ;read key press
	   int 16h 
	   
	   cmp al,27d
	   je menuL
	   
	   cmp al,'q'
	   je Exit
	   
	   jmp CheckBoyWon
	   
;Draw Girl won Proc 	  
GirlWon:
      Call cls 
	  
	   mov [StartPictX],0d
       mov [StartPictY],0d

       mov [word Point_Fname],offset FileGirl
       mov [word Point_Fname+2],seg FileGirl

       call drawPCX
	   
;Check Key Press
CheckGirlWon:	   
       mov ah,00h ;read key press
	   int 16h 
	   
	   cmp al,27d
	   je menuL
	   
	   cmp al,'q'
	   je Exit
	   
	   jmp CheckGirlWon
	  	  
;---------------------------------------------------------------------------------------------------------------------------------------------------------------:::::::::::::::::::::::
;---------------------------------------------------------------------------------------------------------------------------------------------------------------:::::::::::::::::::::::
;---------------------------------------------------------------------------------------------------------------------------------------------------------------:::::::::::::::::::::::
;---------------------------------------------------------------------------------------------------------------------------------------------------------------:::::::::::::::::::::::
;---------------------------------------------------------------------------------------------------------------------------------------------------------------:::::::::::::::::::::::
Exit:
        call cls
        mov ax, 4C00h
        int 21h
	

PROC DrawMaze
		lea si, [maze]
			
		push [start_maze_x]
		pop [x_BitMap]
		
		push [start_maze_y]
		pop [y_BitMap]
	   
		mov cx, maze_max_y
cycle_row:
		push cx
   
		mov cx, maze_max_x
cycle_col:
		push cx
		mov al,[si]
		inc si
		cmp al,1h
		jne @1
		lea di,[WhiteBlock]
		call DrawPict
		jmp next
@1: 	cmp al, 2h
		jne @2
		lea di, [RedBlock]
		call DrawPict
		jmp next
@2:     cmp al,3h
        jne @3
		lea di, [BlueBlock]
		call DrawPict
		jmp next
@3:     cmp al,4h
        jne next
		lea di, [Door]
		call DrawPict
		jmp next

next:
		mov ax,[x_BitMap]
		add ax, title_maxX
		mov [x_BitMap],ax
		pop cx
		loop cycle_col
		mov ax,[y_BitMap]
		add ax,title_maxY
		mov [y_BitMap],ax
		pop cx
		loop cycle_row
        ret 
ENDP DrawMaze
;***********************************************///////
;***********************************************///////
;Draw The BackGround OF The game And Organize the Place of The blocks
;Input :  StartPictX, StartPictY, Point_Fname
;OutPut: BackGround Of The Game
;Registers:ax,cx,si
;***********************************************///////
;***********************************************///////

PROC DrawPict
		push [y_BitMap]
		pop [temp_y]

		mov dl, title_maxY
cycle_y:
		push [x_BitMap]
		pop [temp_x]
		mov dh, title_maxX
cycle_x:   
		mov al,[di]
		inc di
		pusha
		call Draw_pixel
		popa
		inc [temp_x]
		dec dh
		jnz cycle_x       ; loop x
		inc [temp_y]
		dec dl
		jnz cycle_y
ret
ENDP DrawPict

;***********************************************///////
;***********************************************///////
;Draw The Blocks of the BackGround
;Input : none
;OutPut: BackGround Of The Game
;Registers:si,dl.dh
;***********************************************///////
;***********************************************///////

PROC Draw_pixel
		mov bh, 0h
		mov cx, [temp_x]
		mov dx, [temp_y]
		mov ah, 0Ch
		int 10h
		ret
ENDP Draw_Pixel		
		
;***********************************************///////
;***********************************************///////
;Draw the pixel of the BackGround
;Input : None
;OutPut: Draw pixel of the background
;Registers:ah,cx,bh,dx
;***********************************************///////
;***********************************************///////
;-------------------------------------------------------------------------------------------------------------------------------------------			
;-------------------------------------------------------------------------------------------------------------------------------------------		
;-------------------------------------------------------------------------------------------------------------------------------------------		
		
		
proc cls
       mov ax, 13h
	   int 10h
	   ret
	   ENDP cls
	   ;--------------------------------
	   ;output: clearscreen
	   ;registers: ah
	   


proc main
        call cls
		
        mov [StartPictX],0d
        mov [StartPictY],0d

        mov [word Point_Fname],offset FileMenu
        mov [word Point_Fname+2],seg FileMenu 

        call drawPCX

		ret
        ENDP main			

;Draw Menu oF the game
;Registers: none
;output pcx of the menu
;************************

proc PHelp
        Call cls

	    mov [StartPictX],0d
        mov [StartPictY],0d

        mov [word Point_Fname],offset FileHelp
        mov [word Point_Fname+2],seg FileHelp

        call drawPCX

		ret
        ENDP PHelp

;Draw Help oF the game
;Registers: none
;output pcx of the Help
;************************			   
		
;----------------------------------------------------------------------------------------------------Fire Boy:
;----------------------------------Draw Fire Boy IMG:
PROC PDrawBoy
    mov cx, [h_BOYimg]
vertical_loop:
    push cx
    mov cx, [w_BOYimg]
horizontal_loop:
    push cx
    mov bh, 0
    mov cx, [BOYcurrent_x]
    mov dx, [BOYcurrent_y]
    mov al, [si]
    mov ah, 0ch
    int 10h
    inc [BOYcurrent_x]
    inc si
    pop cx
    loop horizontal_loop
    inc [BOYcurrent_y]
    mov ax, [BOYcurrent_x]
    sub ax, [w_BOYimg]
    mov [BOYcurrent_x], ax

    pop cx
    loop vertical_loop
    ret
ENDP PDrawBoy


;Draw boy img
;Registers: cx,bh,dx,ax,si
;************************	
;----------------------------------------------------------------------------------------------------Water GIrl:
;----------------------------------Draw Water Girl IMG:
PROC PDrawGirl
    mov cx, [h_GIRLimg]
vertical_loop_GIRL:
    push cx
    mov cx, [w_GIRLimg]
	
horizontal_loop_GIRL:
    push cx
    mov bh, 0
    mov cx, [GIRLcurrent_x]
    mov dx, [GIRLcurrent_y]
    mov al, [si]
    mov ah, 0ch
    int 10h
    inc [GIRLcurrent_x]
    inc si
    pop cx
    loop horizontal_loop_GIRL
	
    inc [GIRLcurrent_y]
    mov ax, [GIRLcurrent_x]
    sub ax, [w_GIRLimg]
    mov [GIRLcurrent_x], ax

    pop cx
    loop vertical_loop_GIRL
    ret
ENDP PDrawGIRL

;Draw girl img
;Registers: cx,bh,dx,ax,si
;************************	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;-------------------------------------------------------------------------PCX Show Pic


;///////////////////////////////////
;Registers: ax,dx,bx,cx,si
;input: Point_Fname,StartPictX,StartPictY
PROC DrawPCX

;-------- open file 
        mov al, 02h
        lds dx, [Point_Fname]
        mov ah, 3dh
        int 21h
        mov [Handle], ax
		
;--------read from file
        mov ah, 3fh
        mov bx, [Handle]
        mov cx, 64000
        lds dx, [Point_Buffer]
        int 21h
;-------Update LengthPict
        mov [FileLength],ax    
        sub ax,768d+128d+1d
        mov [LengthPict],ax
;--------close file
        mov ah,3Eh
        mov bx,[Handle]
        int 21h
;--------X Max	
        mov si,08h
        mov ax,[word Buffer+si]
        mov [WidthPict],ax
;--------Y Max
        mov si,0Ah
        mov ax,[word Buffer+si]
        mov [HeightPict],ax

        push [StartPictX]
        pop [x]
        push [StartPictY]
        pop [y]

;-------Get Pointer
        mov dx,[FileLength]
        sub dx,768d
        add dx,offset Buffer
        mov bx,dx ;bx = poiter
        mov cx,768 ;Paletter Loop 

;============= Array bx get all colors by palette
Palette:
	    mov al,[bx]
	    shr al,2
	    mov [bx],al
	    inc bx
	    loop Palette
		
        ;video mode
		;Set RGB Value
	    mov dx,ds
	    mov es,dx ;Address RGB
        mov dx,[FileLength]
	    sub dx,768d
	    add dx,offs1et Buffer
	    mov ax,1012h
	    mov bx,00h
	    mov cx,256d    ;color RGB
	    int 10h


	    mov si,127d
        add [LengthPict],128d 

CheckPCX:	    
        inc si
        cmp si,[LengthPict]
	    jae ENDPCX
		
		;Check Pointer Color OR Lenght:
        mov cl,[Buffer+si]
        cmp cl,192
    	jae CheckColor
		
		;Lenght
    	mov al,[Buffer+si]
        mov [color],al 		
        call PutPixel		
        call CheckEndOfLine
		
	    jmp CheckPCX

CheckColor:
        ;Color
    	sub cl,192 
    	inc si  ;Next Pointer
    	mov al,[Buffer+si]
        mov [color],al 
DrawPCXpixel:
        call PutPixel
        call CheckEndOfLine
        dec cl
    	jnz DrawPCXpixel
	    jmp CheckPCX
		
ENDPCX:     ret
ENDP DrawPCX
	
;--------------------put pixel by color and position
;------position == x and y	
;Registers: bh,ax,dx,cx
PROC PutPixel
        pusha     
        mov bh,0h
        mov cx,[x]
        mov dx,[y]
        mov al,[color]
        mov ah,0ch
        int 10h
		popa
		
        ret
ENDP PutPixel

;------------------------------------
;Check if line is End By Size of the Pic and X AND Y
;Registers:dx
PROC CheckEndOfLine
        mov dx,[x]
        sub dx,[StartPictX]
        cmp dx,[WidthPict]    ; [x] >= [StartPictX]+[WidthPict]
        jae LineFeed
        add [x],1
        jmp contret
LineFeed:
        push [StartPictX]
        pop [x]
        add [y],1
ContRet:
        ret
ENDP CheckEndOfLine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	  
		END start
