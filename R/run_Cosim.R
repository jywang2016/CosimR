#' run the co-simulation through BCVTB's command line.
#' @description Run the co-simulation through BCVTB's command line.
#' @param bcvtbpath The installtion of BCVTB. For me, it is `'D:/bcvtb'`
#' @param xmlpath See xmlpath parameters in \code{\link{copy_xml}}
#' @param output See output parameters in \code{\link{write_xml}}
#' @return A xml file. Note: xml_copy function returns no value.
#' @export
run_Cosim <- function(bcvtbpath,xmlpath,output){
  bcvtbjar <- paste0(bcvtbpath,'/bin/BCVTB.jar')
  xmlfile <- outputpath <- paste0(xmlpath,'/',output)
  cmd <- paste('java -jar',bcvtbjar,xmlfile,'-run')
  system(cmd)
  message('Co-simulation ends. You can check the results in',xmlpath)
}