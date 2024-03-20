lire <- function(nomFichier, perequation, classique) {
  
    csv_read = read.csv(nomFichier)

    tabCSV = csv_read[csv_read$libelle == "Arbitre" & 
        !is.na(csv_read$indemnite) &
        csv_read$presence == "P" & 
        (substr(csv_read$lb_nom_abg, 0, 3) %in% classique | csv_read$lb_nom_abg %in% perequation), 
                        c("id", "nom", "prenom", "numero_licence", "indemnite")]

    tabClub = csv_read[csv_read$libelle == "Arbitre" & 
        !is.na(csv_read$indemnite) &
        csv_read$presence == "P" &
        (substr(csv_read$lb_nom_abg, 0, 3) %in% classique), c("lb_nom_abg", "GS1", "GS2", "indemnite")] #je refais un df pour y inclure les championnats avec et sans perequation

    arbitreDF = NULL;    
    clubDF = NULL;

    #traitement pour arbitreDF
    for(id in unique(tabCSV$id))
    {
      arbitreDF = rbind(arbitreDF, 
          data.frame(id=id, 
            nom=tabCSV[tabCSV$id == id, "nom"][1], 
            prenom=tabCSV[tabCSV$id == id, "prenom"][1], 
            licence=tabCSV[tabCSV$id == id, "numero_licence"][1], 
            indemnite=sum(tabCSV[tabCSV$id == id, "indemnite"])))
    }
    
    getFullClubName <- function(clubID) {
      clubFullRow <- tabClub[(substr(tabClub$GS1, 0, 10) == clubID), "GS1"] #je recupere les lignes ou l'id du club est celui donné en paramètre (je pars du principe qu'ils ont tous une taille de 10 mais on aurait pu se débrouiller en faisant encore avec un split et réconpérer la 1ère valeur)

      tempClub = as.character(clubFullRow[1]) #Je recupère la 1ère ligne du df renvoyé (normalement y a bien une ligne pcq c'est la même condition que dans la fonction appelante)

      splittedClub <- strsplit(tempClub, " - ");  #je split en fonction de " - "

      numClub <- splittedClub[[1]][1]

      if(endsWith(tempClub, " - ")) #je vérifie si la ligne finie par " - " (num equipe vide) pcq sinon ce qu'il y a après le dernier " - " n'est pas compté comme un élément de ma list donc elle a 1 de longueur en moins 
      {
        nomClub <- paste(splittedClub[[1]][2:(length(splittedClub[[1]]))], collapse = "-")
      }

      else nomClub <- paste(splittedClub[[1]][2:(length(splittedClub[[1]]) - 1)], collapse = "-")

      return(nomClub);
    }




    for(club in unique(c(substr(tabClub$GS1, 0, 10)))) #je pars du principe qu'un club accueil tjrs. On aurait pu concaténer les listes GS1 et GS2 pour vraiment être sûr
    {
      factureClubMatchDomicile = sum(tabClub[(substr(tabClub$GS1, 0, 10) == club) & !is.na(tabClub$indemnite), "indemnite"])/2
      factureClubMatchExterieur = sum(tabClub[(substr(tabClub$GS2, 0, 10) == club) & !is.na(tabClub$indemnite), "indemnite"])/2
      factureClub = factureClubMatchDomicile + factureClubMatchExterieur

      fullClubName = getFullClubName(club)

      clubDF = rbind(clubDF, data.frame(
          club=fullClubName, 
          facture=factureClub))
    }

    print(head(arbitreDF))
    print(head(clubDF))
}

lire("officiels.csv", perequation=c("PRM", "PRF"), classique=c("DFU", "DMU"))
