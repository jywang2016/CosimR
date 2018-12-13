/*
 This C++ script is the example of CosimR to show how to do co-simulation with EnergyPlus
 The Code is messy because I'm not familiar with the C/C++. 
 You can open a issue and point how to modify it or make it clean.
 Package: CosimR
 Github:	https://github.com/jywang2016/CosimR
 Author: Jiangyu Wang
 Date: 11th Dec, 2018
 Email: jywang_2016@hust.edu.cn
 Reference: schedule example in BCVTB
 Compile: g++ -o Cosim Cosim.cpp -std=c++11
 */
#include <iostream>
#include <string>
#include <regex>
#include <stdio.h>
#include <stdlib.h>

using namespace std;

int main(int argc, char *argv[]){
  
  string error = "the Number of arguments are not correct!";
  if(argc !=4){
    cout<<error<<endl;
    return(1);
  }
  
  smatch result;
  string tempstr = argv[1];
  
  string regex_str("\\d+\\.?\\d*"); 
  regex pat(regex_str,regex::icase);
  
  string::const_iterator iter = tempstr.begin();
  string::const_iterator iterEnd= tempstr.end();
  string strouttemp;
  
  if(regex_search(iter,iterEnd,result,pat)){
    strouttemp = result[0]; //just need the first temperature info
    //cout<<outdoortemp<<endl;
  }
  
  int time;
  char *strtime = (char *) argv[2];
  time = atoi(strtime);
  
  float outtemp;
  char *strtemp = (char *) strouttemp.c_str();
  outtemp = atof(strtemp);
  
  // input const 
  const int DAYSTART = 6*3600;
  const int NIGHTSTART = 16*3600;
  const double TCNIGHT = 30.0;
  const double TCROOLOW = 22.0;
  const double TCROOHIG = 26.0;
  
  const double TCOUTLOW = 20.0;
  const double TCOUTHIG = 24.0;
  
  const double THDAY = 20.0;
  const double THNIGHT = 16.0;
  
  // temp set logic 
  
  double ToutDif;
  ToutDif = outtemp - TCOUTLOW;
  
  double TSetCooOn;
  TSetCooOn = TCROOLOW + ToutDif * (TCROOHIG - TCROOLOW)/(TCOUTHIG - TCOUTLOW);
  
  double TCDay;
  TCDay = max(TCROOLOW,min(TCROOHIG,TSetCooOn));
  
  double THSetPoi;
  double TCSetPoi;
  
  int timeOfDay = time % 86400;
  
  if(timeOfDay > DAYSTART && timeOfDay < NIGHTSTART){
    THSetPoi = THDAY;
    TCSetPoi = TCDay;
  }else{
    THSetPoi = THNIGHT;
    TCSetPoi = TCNIGHT;
  }
  
  cout<<THSetPoi<<","<<TCSetPoi<<", "<<endl;
  
  return 0;
}