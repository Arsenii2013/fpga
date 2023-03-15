#!/usr/bin/env python2

import sys
import os
import getopt
import glob
import subprocess
import time

#-------------------------------------------------------------------------------
#
#     Project
#

project_name = 'hp_tb'

RootDir = '../../'

Src     = [RootDir + 'src',
           RootDir + 'lib/avmm',
           RootDir + 'lib/common']

SrcSim  = ['src', 'src/pcie_rp']

Sources = Src + SrcSim

IpSrcList = ['pcie_ip.fv']

VExt  = 'v'
SVExt = 'sv'

SrcFileList = 'src_files.fv'

#-------------------------------------------------------------------------------
#
#     Toolchain
#
VOPT = 'vopt'
VLC  = 'vlog'
VSIM = 'vsim'

#-------------------------------------------------------------------------------
#
#     Options
#
IncDirs = ''
for i in Sources:
    IncDirs += '+' + i  

CFLAGS  = ' -f ' + SrcFileList
CFLAGS += ' -work wlib'
CFLAGS += ' -incr' 
CFLAGS += ' +incdir' + IncDirs
CFLAGS += ' -sv'
CFLAGS += ' -O5'
#CFLAGS += ' -mfcu'

OPTFLAGS  = ' ' + project_name
OPTFLAGS += ' -o opt_' + project_name
OPTFLAGS += ' -work wlib'
OPTFLAGS += ' -L altera_ver'
OPTFLAGS += ' -L lpm_ver'
OPTFLAGS += ' -L sgate_ver'
OPTFLAGS += ' -L altera_mf_ver'
OPTFLAGS += ' -L altera_lnsim_ver'
OPTFLAGS += ' -L cyclonev_ver'
OPTFLAGS += ' -L cyclonev_hssi_ver'
OPTFLAGS += ' -L cyclonev_pcie_hip_ver'
OPTFLAGS += ' -L stratixiv_ver'
OPTFLAGS += ' -L stratixiv_hssi_ver'
OPTFLAGS += ' -L stratixiv_pcie_hip_ver'
OPTFLAGS += ' +acc'

SFLAGS  = ' -c'
SFLAGS += ' -lib wlib'
SFLAGS += ' -L altera_ver'
SFLAGS += ' -L lpm_ver'
SFLAGS += ' -L sgate_ver'
SFLAGS += ' -L altera_mf_ver'
SFLAGS += ' -L altera_lnsim_ver'
SFLAGS += ' -L cyclonev_ver'
SFLAGS += ' -L cyclonev_hssi_ver'
SFLAGS += ' -L cyclonev_pcie_hip_ver'
SFLAGS += ' -L stratixiv_ver'
SFLAGS += ' -L stratixiv_hssi_ver'
SFLAGS += ' -L stratixiv_pcie_hip_ver'
SFLAGS += ' -t 1ps'
SFLAGS += ' -wlf func.wlf'
SFLAGS += ' '

#-------------------------------------------------------------------------------
#
#     Fuctions
#
def build_srclist(d):

    ip = []

    for item in IpSrcList:
        with open(item) as file:
            for line in file:
                ip.append(line.strip())
    
    v  = []
    sv = []
    for i in d:
        v  += glob.glob(i + '/*.' + VExt)
        sv += glob.glob(i + '/*.' + SVExt)

    flist = ip + v + sv
    
    s = ''
    for i in flist:
        p = os.path.realpath(i)
        s += p.replace('\\', '/') + os.linesep

    open(SrcFileList, 'wb').write(s)

#-------------------------------------------------------------------------------
def launch_tool(cmd):
    p = subprocess.Popen(cmd.split(), universal_newlines = True,
                         stdin  = subprocess.PIPE,
                         stdout = subprocess.PIPE,
                         stderr = subprocess.PIPE )
                    
    out, err = p.communicate()
    out += err
      
    print out
    return p.returncode

#-------------------------------------------------------------------------------
def vlog_compile():
    build_srclist(Sources)

    cmd = VLC + CFLAGS
    out = launch_tool(cmd)
    if out != 0:
        return

    cmd = VOPT + OPTFLAGS
    out = launch_tool(cmd)

def sim():
    cmd = VSIM + SFLAGS + ' opt_test_tb '
    out = launch_tool(cmd)

#-------------------------------------------------------------------------------
def main():
    opt, args = getopt.gnu_getopt(sys.argv[1:], 'cs')
    for i in opt:
        if i[0] == '-c':
            vlog_compile()

        if i[0] == '-s':
            sim()
#-------------------------------------------------------------------------------
if __name__ == '__main__':
    main()

#-------------------------------------------------------------------------------

