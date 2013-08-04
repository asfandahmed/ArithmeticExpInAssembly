 .MODEL SMALL
 .STACK 100H

 .DATA

   PROMPT          DB  0DH,0AH,'Enter an Algebraic Expression : ',0DH,0AH,'$'
   VAL1            DB  ?
   OP              DB  ?
   VAL2            DB  ?
   ;temp             DB  ? ; kyun k AH register keerra kar raha hai mul or div karty waqt

 .CODE
   MAIN PROC
     MOV AX, @DATA                ; initialize DS
     MOV DS, AX

     @START:                      ; jump label

     LEA DX, PROMPT               ; load and print the string PROMPT
     MOV AH, 9
     INT 21H

     XOR CX, CX                   ; clear CX



     @INPUT:                      ; jump label
     MOV AH, 1                    ; set input function
       INT 21H                    ; read a character

       CMP AL, 0DH                ; compare AL with CR
       JE @END_INPUT              ; jump to label @END_INPUT if AL=CR

       CMP AL, "0"                ; compare AL with "0"
       JE @PUSH_NUMBER            ; jump to label @PUSH_NUMBER if AL="0"

       CMP AL, "1"                ; compare AL with "1"
       JE @PUSH_NUMBER            ; jump to label @PUSH_NUMBER if AL="1"

       CMP AL, "2"                ; compare AL with "2"
       JE @PUSH_NUMBER            ; jump to label @PUSH_NUMBER if AL="2"

       CMP AL, "3"                ; compare AL with "3"
       JE @PUSH_NUMBER            ; jump to label @PUSH_NUMBER if AL="3"

       CMP AL, "4"                ; compare AL with "4"
       JE @PUSH_NUMBER            ; jump to label @PUSH_NUMBER if AL="4"

       CMP AL, "5"                ; compare AL with "5"
       JE @PUSH_NUMBER            ; jump to label @PUSH_NUMBER if AL="5"

       CMP AL, "6"                ; compare AL with "6"
       JE @PUSH_NUMBER            ; jump to label @PUSH_NUMBER if AL="6"

       CMP AL, "7"                ; compare AL with "7"
       JE @PUSH_NUMBER            ; jump to label @PUSH_NUMBER if AL="7"

       CMP AL, "8"                ; compare AL with "8"
       JE @PUSH_NUMBER            ; jump to label @PUSH_NUMBER if AL="8"

       CMP AL, "9"                ; compare AL with "9"
       JE @PUSH_NUMBER            ; jump to label @PUSH_NUMBER if AL="9"

       CMP AL, "+"                ; compare AL with "+"
       JE @PUSH_OPERATOR          ; jump to label @PUSH_OPERATOR if AL="+"

       CMP AL, "-"                ; compare AL with "-"
       JE @PUSH_OPERATOR          ; jump to label @PUSH_OPERATOR if AL="-"

       CMP AL, "*"                ; compare AL with "*"
       JE @PUSH_OPERATOR          ; jump to label @PUSH_OPERATOR if AL="*"

       CMP AL, "/"                ; compare AL with "/"
       JE @PUSH_OPERATOR          ; jump to label @PUSH_OPERATOR if AL="/"

       CMP AL, "["                ; compare AL with "["
       JE @PUSH_BRACKET           ; jump to label @PUSH_BRACKET if AL="["

       CMP AL, "{"                ; compare AL with "{"
       JE @PUSH_BRACKET           ; jump to label @PUSH_BRACKET if AL="{"

       CMP AL, "("                ; compare AL with "("
       JE @PUSH_BRACKET           ; jump to label @PUSH_BRACKET if AL="("

       CMP AL, ")"                ; compare AL with ")"
       JE @ROUND_BRACKET          ; jump to label @ROUND_BRACKET if AL=")"
                                   
       CMP AL, "}"                ; compare AL with "}"
       JE @CURLY_BRACKET          ; jump to label @CURLY_BRACKET if AL="}"

       CMP AL, "]"                ; compare AL with "]"
       JE @SQUARE_BRACKET         ; jump to label @SQUARE_BRACKET if AL="]"

       JMP @INPUT                 ; jump to label @INPUT

       @PUSH_BRACKET:             ; jump label

       PUSH AX                    ; push AX onto the STACK
       INC CX                     ; set CX=CX+1
       JMP @INPUT                 ; jump to label @INPUT

       @PUSH_OPERATOR:            ; jump label

       PUSH AX                    ; push AX onto the STACK
       INC CX                     ; set CX=CX+1
       JMP @INPUT                 ; jump to label @INPUT

       @PUSH_NUMBER:              ; jump label

       PUSH AX                    ; push AX onto the STACK
       INC CX                     ; set CX=CX+1
       JMP @INPUT                 ; jump to label @INPUT

       @ROUND_BRACKET:            ; jump label
   
       JMP @POP_VALUES

       @CURLY_BRACKET:

       JMP @POP_VALUES

       @SQUARE_BRACKET:

       JMP @POP_VALUES

      @POP_VALUES:
      POP DX
      DEC CX
      MOV VAL1, DL
      
      POP DX
      DEC CX
      MOV OP, DL

      POP DX
      DEC CX
      MOV VAL2, DL

      JMP @PERFORM_CALC

      @PERFORM_CALC:

      CMP OP, "+"

      		JE  @ADDITION

      CMP OP, "-"
		JE @SUBTRACTION

      CMP OP, "*"
      		JE  @MULIPLICATION
      		
      CMP OP, "/"

     		JE  @DIVISION

      @ADDITION:

      SUB VAL1, 48
      SUB VAL2, 48
	
      MOV AL, VAL1
      ADD AL, VAL2
      ADD AL,48
     
      JMP @PUSH_NUMBER

      @SUBTRACTION:

	SUB VAL1, 48
	SUB VAL2, 48
	
	MOV AL,VAL2
	SUB AL,VAL1
	ADD AL,48
     
     
      JMP @PUSH_NUMBER


      @MULIPLICATION:


      SUB VAL1, 48
      SUB VAL2, 48
	
      MOV AL, VAL1
      MUL VAL2
      ADD AL, 48


      JMP @PUSH_NUMBER

      @DIVISION:
	

        SUB VAL1, 48
        SUB VAL2, 48
	MOV AH,0
	MOV AL,VAL2
	
	DIV VAL1
	ADD AL,48


      JMP @PUSH_NUMBER


      @END_INPUT:
	MOV ah, 2
	MOV dl,0ah
	int 21h
	mov dl,0dh
	int 21h
      POP AX
      MOV dl,al
      MOV AH,2
      INT 21h



     @EXIT:                       ; jump label

     MOV AH, 4CH                  ; return control to DOS
     INT 21H






MAIN ENDP
END MAIN
