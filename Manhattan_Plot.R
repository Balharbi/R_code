args <- commandArgs(trailingOnly = TRUE)
 scriptloc <- args[1]
 results <- args[2]
 outfile <- args[3]
 snpcol <- args[4]
 chrcol <- args[5]
 bpcol <- args[6]
 pcol <- args[7]
 

 print ("Reading data")
#Read in data
#get number of rows in file (reads file faster)
 nr <- as.numeric(system(paste("wc -l", results, " | awk \'{print $1}\' "),intern=T))
#get list of numeric column classes (reads file faster)
 dat_temp <- read.table(results, header=T,nrows=50,stringsAsFactors=F)
 classes_to_use <- sapply(dat_temp , class)
#read file
 dat <- read.table (results, header=T,stringsAsFactors=F)


 print ("Loading Manhattan Script")
 source(scriptloc)

  SNP <- dat[,snpcol]
  CHR <- dat[,chrcol]
  BP <- dat[,bpcol]
  P <- dat[,pcol]

 print ("Plotting data")
    ManhattanPlot_AJS_cut(CHR, BP, P, SNP, genomesig = 5*(10^-8), genomesug = 5*(10^-6),photoname = '', 
    outname = outfile, colors = c(rgb(128,161,103,max=255),'black'), sigcolor = 'darkred', sugcolor = 'indianred', ncex = .5, 
    plotsymbol = 18, sugcex = 1, sigcex = 1.5, nonautosome = c(23,24,25,26),xlabel = 'Chromosomal Positions',ylabel = '-log10(p-value)', 
    pdf = 'FALSE',topsnplabels = 'FALSE', pvalue_miss = 'NA')
