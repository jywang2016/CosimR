#' Modify the xml according to your Co-simulation requirements.
#' @description Four parts, including Simulation time, ArraryExtract, EnergyPlus simulator and
#' SystemCommand actor, can be modified.
#' @param xmlpath \dots see \code{\link{copy_xml}}
#' @param timeStep default = 15*60 secs. It depends on your timestep parameters in Energyplus 
#' file. By the way, both of the numerical value 15*60 and string "15*60" are supported. But if
#' you want view your xml file, the string form is adviced since it makes you know your step is 
#' 15mins while the numerical value will show confused 900 secs in the BCVTB view.
#' @param beginTime default = 0. Zero means it begin with the date you set in the EnergyPlus 
#' file. Similarly, input a string `'1*24*3600'` is more recommended than a  numerical
#' value 1*24*3600. 
#' @param endTime default = 4*24*3600. It indicates the co-simulation period is 4 days.
#' @param extractLength default = 2. It equals to the variables you want input to the 
#' EnergyPlus.
#' @param idf The idf path. Generally speaking, the idf should be in the root directory of your
#' co-simulation project. Therefore, you can use `paste0(xmlpath,'/SmOffPSZ.idf')` to indicate 
#' your idf path if your idf name is SmOffPSZ.
#' @param epw The weather file path.
#' @param outname default = 'eplusout'. You can use outname to specify the name of messy 
#' simulation results files.
#' @param programname default = 'Rscript'. It means you use \emph{R} exchange data with EnergyPlus.
#' If you set up R path in your environment variable, you can leave it alone. 
#' Or you need specify the complete path of Rscript as 'Your path/R/bin/Rscript'. Similarly,
#' you could set programname as 'python' if you use python to do the co-simulation with 
#' Energyplus. \emph{It is worth noting that you should list the complete path if you use your own 
#' C/C++ based application since there is no environment variable to specify its path.} 
#' @param programArgs 
#' \enumerate{
#'   \item If your programname is 'Rscript', the programArgs should be 'YourScriptName.R'
#'   \item If your programname is 'python', the programArgs should be 'YourScriptName.py'
#'   \item If your programname is 'path/to/your/application', the programArgs should be 
#' "", an empty char.
#' }
#' @param workingDir The subfolder path (usually under your xmlpath) you place your script or 
#' application. If you use R, `paste0(xmlpath,'/R')` is a good choice. For python user, it is
#' `paste0(xmlpath,'/python')`. For cpp user, it is `paste0(xmlpath,'/cpp')`. If there is no 
#' folder path as you specified, the function will create a new one.
#' @param cpp default = FALSE. If the external program is .exe or .sh, which is developed by 
#' yourself, the cpp should be set as \emph{TRUE}
#' @return The rootnode of the modified xml. It will be imported as the rootnode parameter.
#' See \code{\link{write_xml}}.
#' @import XML
#' @export
modify_xml <- function(xmlpath,
                       #timeset
                       timeStep = 15*60,
                       beginTime = 0,
                       endTime = 4*24*3600,
                       #arrayExtract
                       extractLength = 2,
                       #energyplus
                       idf,
                       epw,
                       outname,
                       #syscommand
                       programname = 'Rscript',
                       programArgs,
                       workingDir,
                       cpp = FALSE){
  # read the xml file
  #library(XML)
  xmlpath2 <- paste0(xmlpath,'/CosimR.xml')
  cosim <- xmlParse(xmlpath2)
  rootnode <- xmlRoot(cosim)
  
  # co-simulation time modify
  xmlAttrs(rootnode[[3]])[['value']] <- as.character(timeStep) #timeStep 
  xmlAttrs(rootnode[[4]])[['value']] <- as.character(beginTime) #beginTime
  xmlAttrs(rootnode[[5]])[['value']] <- as.character(endTime) #endTime
  
  message("Part1: Cosim time set modify >>>>>>>>>")
  cat('timeStep:',xmlAttrs(rootnode[[3]])[['value']],
      'beginTime:',xmlAttrs(rootnode[[4]])[['value']],
      'endTime:',xmlAttrs(rootnode[[5]])[['value']],'\n')
  
  # arraryExtract modify
  xmlAttrs(rootnode[[19]][[1]])[['value']] <- as.character(extractLength)
  xmlAttrs(rootnode[[19]][[3]])[['value']] <- as.character(extractLength)
  
  message("Part2: ArrayExtract actor pram.args modify >>>>>>>>>")
  cat('extractLength:',xmlAttrs(rootnode[[19]][[1]])[['value']],
      'outputArrayLength:',xmlAttrs(rootnode[[19]][[3]])[['value']],'\n')
  
  # energyplus simulator modify
  
  message("Part3: EnergyPlus Simulator pram.args modify >>>>>>>>>")
  eplus1 <- paste('-w',epw,'-p',outname,'-s C -x -m -r',idf)
  eplus <- paste('\"',eplus1,'\"')
  xmlAttrs(rootnode[[11]][[2]])[['value']] <- eplus
  cat('energyplus command:',eplus,'\n')
  
  # system command modify
  # if not exists working Dir, then create
  if(!dir.exists(workingDir)){
    cat('the workding dir is created! \n')
    dir.create(workingDir)
  }
  programArgs2 <- paste0('\"',workingDir,'/',programArgs,' $input $time $iteration\"')
  simlog <- paste0(workingDir,'/simulation.log')
  
  # if use .exe in windows, the programArgs should just be programArgs
  # if use .exe in windows, the programname should be added to the end of workdingDir
  if(cpp){
    programname <- paste0(programname)
    programArgs2 <- paste0('\"',programArgs,' $input $time $iteration\"')
  }
  
  xmlAttrs(rootnode[[17]][[1]])[['value']] <- programname #'Rscript'
  xmlAttrs(rootnode[[17]][[2]])[['value']] <- programArgs2 # 
  xmlAttrs(rootnode[[17]][[3]])[['value']] <- workingDir
  xmlAttrs(rootnode[[17]][[4]])[['value']] <- simlog#simulation
  
  message("Part4: SystemCommand pram.args modify >>>>>>>>>")
  cat('programname:',programname,'\n')
  cat('programArgs:',programArgs2,'\n')
  cat('workingDir:',workingDir,'\n')
  cat('simulationLog:',simlog,'\n')
  
  message("---------------- Modification End ----------------")
  # return your modified xml file
  return(rootnode)
}