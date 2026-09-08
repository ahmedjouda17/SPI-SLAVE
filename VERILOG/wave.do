onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider RECIEVE
add wave -noupdate /TB/DUT/SPI_S/clk
add wave -noupdate /TB/DUT/SPI_S/rst_n
add wave -noupdate /TB/DUT/SPI_S/ss_n
add wave -noupdate /TB/DUT/SPI_S/cs
add wave -noupdate /TB/DUT/SPI_S/MOSI
add wave -noupdate /TB/DUT/SPI_S/cnt
add wave -noupdate /TB/DUT/ram/din
add wave -noupdate /TB/DUT/SPI_S/rx_data
add wave -noupdate /TB/DUT/ram/w_add
add wave -noupdate -color Gold /TB/DUT/SPI_S/rx_valid
add wave -noupdate -divider SEND
add wave -noupdate /TB/DUT/SPI_S/cnt_r
add wave -noupdate /TB/DUT/SPI_S/tx_data
add wave -noupdate -color Gold /TB/DUT/SPI_S/tx_valid
add wave -noupdate /TB/DUT/ram/dout
add wave -noupdate /TB/DUT/SPI_S/MISO
add wave -noupdate -divider MEMORY
add wave -noupdate -color Magenta {/TB/DUT/ram/mem[19]}
add wave -noupdate -color Magenta {/TB/DUT/ram/mem[18]}
add wave -noupdate -color Magenta {/TB/DUT/ram/mem[17]}
add wave -noupdate -color Magenta {/TB/DUT/ram/mem[16]}
add wave -noupdate -color Magenta {/TB/DUT/ram/mem[15]}
add wave -noupdate {/TB/DUT/ram/mem[14]}
add wave -noupdate {/TB/DUT/ram/mem[12]}
add wave -noupdate {/TB/DUT/ram/mem[11]}
add wave -noupdate {/TB/DUT/ram/mem[10]}
add wave -noupdate {/TB/DUT/ram/mem[9]}
add wave -noupdate {/TB/DUT/ram/mem[8]}
add wave -noupdate {/TB/DUT/ram/mem[7]}
add wave -noupdate {/TB/DUT/ram/mem[6]}
add wave -noupdate {/TB/DUT/ram/mem[5]}
add wave -noupdate {/TB/DUT/ram/mem[4]}
add wave -noupdate {/TB/DUT/ram/mem[3]}
add wave -noupdate {/TB/DUT/ram/mem[2]}
add wave -noupdate {/TB/DUT/ram/mem[1]}
add wave -noupdate {/TB/DUT/ram/mem[0]}
add wave -noupdate /TB/DUT/ram/tx_pending
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {570 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 164
configure wave -valuecolwidth 62
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1024 ns}
