# read a csv file and save the data in an RData file.
# This is used by calling Rscript with an argument (name of the csv file
# ).
# The RData file and the data frame inside are both named the same as
# the csv file. The SYMBOL, DATE and other fileds may be unnecessary
# which can be ignored to get a smaller file.
#
# TODO: read.csv column types for milli-second data.
#
# Usage:
#   Rscript TAQcsv2RData.R FILENAME.csv

csvfilename <- commandArgs(trailingOnly=T)
basedir <- dirname(csvfilename)
fileid <- sub("^([^.]*).*", "\\1", basename(csvfilename))
outfilename <- paste(basedir, "/", fileid, ".RData", sep="")

header <- as.character(read.csv(csvfilename, nrow=1,
                                header=FALSE, colClasses="character"))
if ("PRICE" %in% header) {
  if ("TIME_M" %in% header) {
    # TODO: specify column types for milli-second data
  } else {
    coltypes <- c("factor", "integer", "character", "numeric",
                  "integer", "integer", "integer", "character",
                  "character")
  }
} else {
  if ("TIME_M" %in% header) {
    # TODO: specify column types for milli-second data
  } else {
    coltypes <- c("factor", "integer", "character", "numeric",
                  "numeric", "integer", "integer", "integer",
                  "character", "character")
  }
}
temp.df <- read.csv(csvfilename, colClasses=coltypes)

assign(fileid, temp.df)
save(list=fileid, file=outfilename)