% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/copy_xml.R
\name{copy_xml}
\alias{copy_xml}
\title{copy the xml file to the target directory}
\usage{
copy_xml(xmlpath, overwrite = TRUE)
}
\arguments{
\item{xmlpath}{The dir you want palce your xml file. Meanwhile, it is also the directory of 
your co-simulation project.For me, set the path under the \emph{examples} folder of the BCVTB 
installation path is a good choice, namely 'D:/bcvtb/examples/ mydir'.}

\item{overwrite}{default = TRUE. If there already exists CosimR.xml in your xmlpath, it will
be overwritten.}
}
\value{
A xml file. Note: xml_copy function returns no value.
}
\description{
Copy the minimum xml file (CosimR.xml) to the target directory, 
for instance, 'C:/bcvtb/examples/your dir/Cosim.xml' in the Windows OS.
}
