onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_apb/dut/PCLK
add wave -noupdate /tb_apb/dut/PRESETn
add wave -noupdate /tb_apb/dut/PSEL
add wave -noupdate /tb_apb/dut/PENABLE
add wave -noupdate /tb_apb/dut/PWRITE
add wave -noupdate /tb_apb/dut/PADDR
add wave -noupdate /tb_apb/dut/PWDATA
add wave -noupdate /tb_apb/dut/PRDATA
add wave -noupdate /tb_apb/dut/PREADY
add wave -noupdate /tb_apb/dut/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {82 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 169
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
WaveRestoreZoom {54 ns} {92 ns}
