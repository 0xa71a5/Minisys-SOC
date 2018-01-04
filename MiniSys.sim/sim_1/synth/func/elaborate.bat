@echo off
set xv_path=D:\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto bf4d60825a14418bb25d40e51d870108 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L secureip --snapshot line_sim_func_synth xil_defaultlib.line_sim xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
