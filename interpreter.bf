For the interpreter there are two tapes with unbounded size (within the
interpreter's limitations): progam and data
These are laid out side by side on the simulator data tape since the tape is
bounded on the left side with:
    the first program element in the first cell
    the first data element in the second cell
    two placeholder cells for computation and keeping track where the
        data and instruction pointers are wrt to each other
    the second program element in the fifth cell
    and so forth


Turns out comments are a bit difficult since some punctuation and arithmetic
symbols aren't allowed

BF command       ASCII value (dec)   Translated symbol
increment        43                  1
decrement        45                  2
move left        60                  3
move right       62                  4
start loop       91                  5
end loop         93                  6
read in          44                  7
write out        46                  8
and the interpreter addition
start of input   36                  0

First read all of the instructions (separated from input by an dollar sign)


>>>>+
[#->, read input to cell 2 relative to where we start from
>>>+<<< Mark cell 5 (next iteration's cell 2) as active
For each of the possible characters the following goes and checks equality for
it; if it is equal it sets cell 1 to a certain value and moves to cell 3

Start of input:
>++++++[<------>-]          cell 2 minus 36
                            cell 2 is zero if we've reached start of input
>>-<<<[>>>+<<]<[<]>         in which case unmark cell 5
Increment
-------                     if it isn't zero: sub 9: 0 if input was 43
<+>[<-<]>>[>>]<<        add 1 to cell 1 if zero
Read in
-<+++++++>[<-------<]       sub 1 (0 if 44) and set cell 1 to 7 if zero
>>[>>]<<   
Decrement
-<++>[<--<]>>[>>]<<         sub 1 (0 if 45) and set cell 1 to 2 if zero
Write out
-<++++++++>[<--------<]>>[>>]   <<     sub 1 (46) if 0 set 8
Move right
>++[<------->-]<            sub 14 (at 60)
<+++>[<---<]>>[>>]<<                if zero set to 3
Move left
--<++++>[<----<]>>[>>]<<        sub 2 (62) set 4 if 0
Start loop
>++++[<------->-]<-           sub 29 (91)
<+++++>[<-----<]>>[>>]<<        set 5 if 0
End loop
--<++++++>[<------<]>>[>>]<<    sub 2; set 6

[+]                         Zero cell 2

Pointer is now at cell 2
cell 1 contains the code for a valid symbol (between 1 and 8 inclusive) or zero
cell 5 (next cell 1) contains 1 if we want to continue reading
    (ie last symbol wasnt start of input)
+<[>->]<<[<<]>>>               Place 1 on cell 2 if cell 1 is zero
[>>>[-<<<<+>>>>]<<<-<<<<]      if true move cell 5 to cell 1 and move 4 left
>>>]                          move to cell 1 or cell 5; zero if 
