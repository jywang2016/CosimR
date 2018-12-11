#	This R script is the example of CosimR to show how to do co-simulation with EnergyPlus
#	Package: CosimR
#	Github:	https://github.com/jywang2016/CosimR
#	Author: Jiangyu Wang
#	Date: 11th Dec, 2018
#	Email: jywang_2016@hust.edu.cn
#	Reference: schedule example in BCVTB

args=commandArgs(T)
e  = args[1]
time = args[2]
iter = args[3]

m <- unlist(stringr::str_extract_all(e,'\\d+\\.?\\d*'))
tout = as.numeric(m)[1]

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
time = as.numeric(time)

ToutDif = tout - TCOutLow

TSetCooOn = TCRooLow + ToutDif * (TCRooHig - TCRooLow)/(TCOutHig - TCOutLow)
TCDay = max(TCRooLow,min(TCRooHig,TSetCooOn))

if(time %% 86400 > dayStart && time %% 86400 < nightStart){
	THSetPoi = THDay
	TCSetPoi = TCDay
}else{
	THSetPoi = THNight
	TCSetPoi = TCNight
}

cat(THSetPoi,',',TCSetPoi,',',sep = '')
