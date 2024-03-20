import pandas as pd

def lire(nomFichier, perequation, classiques):

    df = pd.read_csv(nomFichier)    
    filtDF = df[(df.libelle == 'Arbitre') 
                    & (df.indemnite.notnull())
                        & (df.presence == 'P')
                            & (df.lb_nom_abg.isin(perequation) | df.lb_nom_abg.str.slice(0,3).isin(classiques))].filter(items=['id', 'GS1', 'GS2', 'nom', 'prenom', 'numero_licence', 'indemnite', 'lb_nom_abg'])
        

    arbitreDF = pd.DataFrame({'id':{}, 'nom':{}, 'prenom':{}, 'numero_licence':{}, 'indemnite':{}})

    for id in filtDF.id.unique():
        
        if(arbitreDF[arbitreDF.id == id].empty):

            somme = sum(filtDF[filtDF.id == id]['indemnite'])

            newRow = filtDF[filtDF.id == id].iloc[0]
            newRow.indemnite = somme
            arbitreDF.loc[len(arbitreDF)] = (newRow)


    clubDF = pd.DataFrame({'club':{}, 'facture':{}})

    filtClubDF = filtDF[~df.lb_nom_abg.isin(perequation)]

    allFullClub = pd.concat([filtClubDF.GS1, filtClubDF.GS2])

    for club in allFullClub:
        print(club[0])

        NomClub = []

        for i in range(club.len()-1):
            NomClub.append(club[i])
            
        if(clubDF[clubDF.club == club[1]].empty):

            

            fullNameClub = " - ".join(club)

            somme = sum(filtClubDF[filtClubDF.GS1.str[:10] == club[0]]['indemnite'])/2 + sum(filtClubDF[filtClubDF.GS2.str[:10] == club[0]]['indemnite'])/2

            newRow = {'club': club[1], 'facture': somme}
            clubDF.loc[len(clubDF)] = (newRow)


    print(arbitreDF)
    print(clubDF)

lire(nomFichier='officiels.csv', perequation=['PRM', 'PRF'], classiques=["DMU", "DFU"])



