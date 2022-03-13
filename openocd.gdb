# Sample OpenOCD configuration script for GDB session

# connect to gdb remote server
target remote :3333

# reset device after connection of remote port (optional, uncomment if you are running into flashing problems)
# monitor reset halt

# enable demangling asm names on disassembly
set print asm-demangle on

# enable pretty printing
set print pretty on

# disable style sources as the default colors can be hard to read
set style sources off

# set backtrace limit to not have infinite backtrace loops
set backtrace limit 32

# detect unhandled exceptions, hard faults and panics
break DefaultHandler
break HardFault
break rust_begin_unwind
# run the next few lines so the panic message is printed immediately
# the number needs to be adjusted for your panic handler
# commands $bpnum
# next 4
# end

# turn on semihosting
monitor arm semihosting enable

# turn on itm port
monitor itm port 0 on

# *try* to stop at the user entry point (it might be gone due to inlining)
# (sets a breakpoint at main, aka entry)
break main

# send captured ITM to the file itm.fifo
# (the microcontroller SWO pin must be connected to the programmer SWO pin)
# 8000000 must match the core clock frequency
# monitor tpiu config internal itm.txt uart off 8000000

# OR: make the microcontroller SWO pin output compatible with UART (8N1)
# 8000000 must match the core clock frequency
# 2000000 is the frequency of the SWO pin
# monitor tpiu config external uart off 8000000 2000000

# load command will flash the code to the device
load

# start the process but immediately halt the processor
stepi



# OPTIONAL
# continue running until program hits the main breakpoint
# continue

# step from the trampoline code in entry into main
# step
