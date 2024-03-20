read <- function(nomFichier){
    readedTSV <- read.csv(nomFichier, sep='\t', encoding='latin1')
    sortedDF <- readedTSV[order(readedTSV$Identité, readedTSV$Âge, decreasing=TRUE),]
}

read('eleves.tsv')