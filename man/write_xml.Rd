% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/write_xml.R
\name{write_xml}
\alias{write_xml}
\title{write the modified xml file to the target directory}
\usage{
write_xml(rootnode, xmlpath, output)
}
\arguments{
\item{rootnode}{The rootnode of xml file. More specifically, the return object of 
\code{\link{modify_xml}}}

\item{xmlpath}{See xmlpath parameters in \code{\link{copy_xml}}}

\item{output}{new \emph{file name} of your output xml file. For example, output = 'new.xml'.
Do not specify the path of your output xml file.}
}
\value{
A new xml file which will be placed in the xmlpath.
}
\description{
Write the modified xml file to the target directory.
}
