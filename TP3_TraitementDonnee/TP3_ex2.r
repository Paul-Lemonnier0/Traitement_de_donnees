elfRead <- function() {
    tab <- read.table("elf1.txt", head=TRUE)

    tab$sexe = ifelse(tab$SEXE == 0, "Homme", "Femme")
    tab$etud = ifelse(tab$ETUD == 0, "NR", 
                    ifelse(tab$ETUD == 1, "Primaire", 
                        ifelse(tab$ETUD == 2, "Secondaire", 
                            ifelse(tab$ETUD == 3, "Bac", "Superieur"))))

    elfTab <- table(tab$etud, tab$sexe)

    sumStudent <- sum(elfTab)

    pourcentage <- function(x) round(sum(x)*100/sumStudent, digits=1)

    elfTab <- addmargins(elfTab, 1, list(list(pctSexe = pourcentage)))
    elfTab <- addmargins(elfTab, 2, list(list(pctEtude = pourcentage)))

    numberOfRow = nrow(elfTab)
    numberOfCol = ncol(elfTab)

    index <- 1

    for(e in elfTab)
    {
        if(index %% numberOfRow == 0 | index > numberOfRow*(numberOfCol-1))
        {
            elfTab[index] <- paste(e, "%")
        }

        index <- index+1
    }

    print(elfTab)
}

elfRead()