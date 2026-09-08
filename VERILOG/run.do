vlib work
vlog SPI.v RAM.v TOP.v TB.v
vsim -voptargs=+acc work.TB
add wave *
do wave.do
run -all
#quit -sim