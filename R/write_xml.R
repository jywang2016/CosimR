#' write the modified xml file to the target directory
#' @description Write the modified xml file to the target directory.
#' @param xmlpath See xmlpath parameters in \code{\link{copy_xml}}
#' @param rootnode The rootnode of xml file. More specifically, the return object of 
#' \code{\link{modify_xml}}
#' @param output new \emph{file name} of your output xml file. For example, output = 'new.xml'.
#' Do not specify the path of your output xml file.
#' @return A new xml file which will be placed in the xmlpath.
#' @import XML
#' @export
write_xml <- function(rootnode,xmlpath,output){
  #tmp <- paste0(tempdir(),'/tmp.xml')
  tmp <- './tmp.xml'
  saveXML(rootnode,file = tmp)
  
  # dtd info parse
  xmlpath2 <- paste0(xmlpath,'/CosimR.xml')
  part1 <- readLines(xmlpath2)
  dtd <- paste0(part1[1:3],collapse = '\n')
  
  # entity info parse
  outputpath <- paste0(xmlpath,'/',output)
  part2 <- suppressWarnings(readLines(tmp))
  file.remove(tmp)
  entity <- paste0(part2,collapse = '\n')
  final <- c(dtd,entity)
  write.table(final,file = outputpath,row.names = FALSE,col.names = FALSE,quote = FALSE)
  
  if(file.exists(outputpath)){
    message(output,' is written successfully!')
  }
}