### R code from vignette source 'cqn.Rnw'

###################################################
### code chunk number 1: cqn.Rnw:7-8
###################################################
options(width=70)


###################################################
### code chunk number 2: load
###################################################
library(cqn)
library(scales)
library(edgeR)

dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")

input <- function(inputfile) {
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
    pfix = prefix()
  if (length(pfix) != 0) {
     pfix <<- paste(pfix, "/", sep="")
  }
}

run <- function() {}

output <- function(outputfile) {

montgomery.subset <- read.table(paste(pfix, parameters["dataset", 2], sep="/"), sep=",")
sizeFactors.subset <- as.double(read.csv(paste(pfix, parameters["sizefactors", 2], sep="/")))
uCovar <- read.table(paste(pfix, parameters["covar", 2], sep="/"), sep=",")

pdf(paste(outputfile,"pdf",sep="."))
cqn.subset <- cqn(montgomery.subset, lengths = uCovar$length, 
                  x = uCovar$gccontent, sizeFactors = sizeFactors.subset,
                  verbose = TRUE)
cqnplot(cqn.subset, n = 1, xlab = "GC content", lty = 1, ylim = c(1,7))
cqnplot(cqn.subset, n = 2, xlab = "length", lty = 1, ylim = c(1,7))
saveRDS(cqn.subset, paste(outputfile,"rds",sep="."))
}
