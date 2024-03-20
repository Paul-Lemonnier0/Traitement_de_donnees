BEGIN{
    FS=",";
    nomFichier="bienFormaté.txt"
}

NR == 1 {
    print $1","$2","$3 >> nomFichier
}

NF > 0 {

    matchedDate = match($3, /^(0[1-9]|[1-2][0-9]|3[0-1])\/(0[1-9]|1[0-2])\/([0-9][0-9]|[0-2][0-2])$/)
    matchedLongDate = match($3, /^(0[1-9]|[1-2][0-9]|3[0-1])\/(0[1-9]|1[0-2])\/(19[0-9][0-9]|20[0-2][0-2])$/)

    if(matchedDate != 0 || matchedLongDate != 0)
    {
        if(matchedLongDate != 0) printf $1","$2","$3 >> nomFichier
        else {
            prefixYear
            split($3, splitDate, "/")

            if(splitDate[3] >= 22) prefixYear="19"
            else prefixYear = "20"
            
            printf $1","$2","splitDate[1]"/"splitDate[2]"/"prefixYear""splitDate[3] >> nomFichier
        }

        print "" >> nomFichier
    }

    else 
    {
        printf "mal formatée : "
        for(i=1;i<=NF;++i)
        {
            printf $i " "
        }
        print""
    }
}

