@echo off
set xv_path=D:\\Vivado\\2016.2\\bin
call %xv_path%/xsim sim_line_simple_behav -key {Behavioral:sim_1:Functional:sim_line_simple} -tclbatch sim_line_simple.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
