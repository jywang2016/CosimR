"""
 	This python script is the example of CosimR to show how to do co-simulation with EnergyPlus
 	Package: CosimR
	Github:	https://github.com/jywang2016/CosimR
	Author: Jiangyu Wang
	Date: 11th Dec, 2018
	Email: jywang_2016@hust.edu.cn
	Reference: schedule example in BCVTB
"""

import re
import sys

string = sys.argv[1]
time = sys.argv[2]
iter = sys.argv[3]

m = re.findall(r"\d+\.?\d*",string)

tout = float(m[0])

# input const -----------------------
dayStart = 6*3600
nightStart = 16*3600
TCNight = 30
TCRooLow = 22
TCRooHig = 26

TCOutLow = 20
TCOutHig = 24

THDay = 20
THNight = 16

# temp set logic ----------------------
time = int(float(time))

ToutDif = tout - TCOutLow

TSetCooOn = TCRooLow + ToutDif * (TCRooHig - TCRooLow)/(TCOutHig - TCOutLow)
TCDay = max(TCRooLow,min(TCRooHig,TSetCooOn))

if time % 86400 > dayStart and time % 86400 < nightStart:
	THSetPoi = THDay
	TCSetPoi = TCDay
else:
	THSetPoi = THNight
	TCSetPoi = TCNight

#print(THSetPoi,',',TCSetPoi,',',sep='')

strs = [str(THSetPoi),str(TCSetPoi),' ']

sys.stdout.write(','.join(strs))
