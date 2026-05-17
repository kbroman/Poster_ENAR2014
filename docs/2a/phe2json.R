phe2json <-
function(phe, file="phe_vs_time.json")
{
  cn <- colnames(phe)
  time <- as.numeric(substr(cn, 2, nchar(cn)))
  dimnames(phe) <- NULL

  library(RJSONIO)
  cat0 <- function(file, ...) cat(..., sep="", file=file)
  cat0a <- function(file, ...) cat(..., sep="", file=file, append=TRUE)

  cat0(file, "{\n")
  cat0a(file, "\"time\" : \n", toJSON(time), ",\n\n")
  cat0a(file, "\"phe\" : \n", toJSON(phe), "\n\n")
  cat0a(file, "}\n")
}

phe <- as.matrix(read.csv("phe.csv", as.is=TRUE))
phe2json(phe)

