
set project_name hp_tb

radix -hex

proc cc { } {
    global bin
    vlog -f src_files.fv -work wlib -incr +incdir+../../Src -sv -O5
    vopt test_tb -o opt_test_tb -work wlib +acc -L altera_ver \
                                                -L lpm_ver \
                                                -L sgate_ver \
                                                -L altera_mf_ver \
                                                -L altera_lnsim_ver \
                                                -L cyclonev_ver \
                                                -L cyclonev_hssi_ver \
                                                -L cyclonev_pcie_hip_ver \
                                                -L stratixiv_ver \
                                                -L stratixiv_hssi_ver \
                                                -L stratixiv_pcie_hip_ver
}

proc c { } {
    exec ./build.py -c > out
    set f [open out r]
    set s [read $f]
    close $f
    file delete out
    puts $s

}

proc sim { } {
    global project_name

    quit -sim
    vsim -c -lib wlib -L altera_ver \
                      -L lpm_ver \
                      -L sgate_ver \
                      -L altera_mf_ver \
                      -L altera_lnsim_ver \
                      -L cyclonev_ver \
                      -L cyclonev_hssi_ver \
                      -L cyclonev_pcie_hip_ver \
                      -L stratixiv_ver \
                      -L stratixiv_hssi_ver \
                      -L stratixiv_pcie_hip_ver \
    -t 1ps -wlf func.wlf -quiet opt_$project_name 
    
    radix -hex
    log -r *
    run 10 ns
    do wave.tcl
    set t1 [clock seconds]
    run -all
    set t2 [clock seconds]
    set dt [expr $t2 - $t1]
    puts "Simulation time: $dt s."
}

proc show { } {
    do wave.do
    run 100ns
    do mem.do
    view wave
}  

proc show_res { a } {
    #do uart.wave.do
    switch $a \
        "mem"      { do mem.wave.do; do mem.do } \
        "video"    { do video.wave.do } \
        "serial"   { do serial.wave.do } \
        "cmi"      { do cmi.wave.do; do cmi.mem.do } \
        "ldr"      { do ldr.wave.do; } \
        "fram"     { do fram.wave.do; } \
        "camrc"    { do camrc.wave.do; } \
        "udp"      { do udp.wave.do; } \
        "default"  "puts {Unknown variant. Supported the following variants: mem, video, serial, cmi, ldr, fram, camrc, udp }"
    
    view wave
    view transcript
}  


proc s { a } {
    sim
    show_res $a
}


#proc s { } {
#    sim
#    show
#}

proc r { } {
    restart -force
    run -all
    view wave
    view transcript
    #show_res $a
}

proc cs { } {
    c
    s
}

