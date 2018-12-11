#' copy the xml file to the target directory
#' @description Copy the minimum xml file (CosimR.xml) to the target directory, 
#' for instance, 'C:/bcvtb/examples/your dir/Cosim.xml' in the Windows OS.
#' @param xmlpath The dir you want palce your xml file. Meanwhile, it is also the directory of 
#' your co-simulation project.For me, set the path under the \emph{examples} folder of the BCVTB 
#' installation path is a good choice, namely 'D:/bcvtb/examples/ mydir'.
#' @param overwrite default = TRUE. If there already exists CosimR.xml in your xmlpath, it will
#' be overwritten.
#' @return A xml file. Note: xml_copy function returns no value.
#' @export
copy_xml <- function(xmlpath,overwrite = TRUE){
  if(!dir.exists(xmlpath)){
    message('the xmlpath is created! \n')
    dir.create(xmlpath)
  }
  frompath <- system.file("extdata/CosimR.xml", package = "CosimR")
  status <- file.copy(from = frompath,
                      to = xmlpath,
                      overwrite = overwrite)
  
  if(status){
    message('CosimR.xml is copied to ',xmlpath,' successfully!')
  }else{
    message('XML file copy failed!')
  }
}