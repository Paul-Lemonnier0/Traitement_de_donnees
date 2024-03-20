lire <- function(nomFichier){
    readedTSV <- read.csv(nomFichier, sep='\t', encoding='latin1')
    sortedDF <- readedTSV[order(readedTSV["Identité"], readedTSV["Âge"], decreasing=TRUE),]


    fitleredDF <- unique(sortedDF[c("Identité", "Sexe")])
    print(colnames(fitleredDF))

}

lire('eleves3.tsv')