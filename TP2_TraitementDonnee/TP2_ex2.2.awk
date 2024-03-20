NR == 1 {
    print($1","$2","$3) >> "bienFormaté.txt";
}

NR != 1 && NF > 0 {

    nbElementsDate = split($3, splitDate, "/");

    isDateCorrect = 1;

    if(nbElementsDate == 3)
    {
        if(splitDate[1] > 0 && splitDate[1] <= 31) {
            if(length(splitDate[1]) != 2) isDateCorrect = 0;
        }

        else isDateCorrect = 0;

        if (splitDate[2] > 0 && splitDate[2] <= 12) {
            if(length(splitDate[1]) != 2) isDateCorrect = 0;
        }

        else isDateCorrect = 0;

    }

    else isDateCorrect = 0

    if(isDateCorrect == 0) {
        printf("Ligne " NR  " : '");

        for(i=1; i<=nbElementsDate; ++i)
        {
            if(i==nbElementsDate) printf(splitDate[i]);
            else printf(splitDate[i] "/");
        }
            
        print("' mal formée : ignorée");
    }

    else {
        anneeBienFormatee = splitDate[3];

        if(length(splitDate[3]) == 2)
        {
            if(splitDate[3] <= 22) anneeBienFormatee = "20" splitDate[3];
            else anneeBienFormatee = "19" splitDate[3];
        }

        print($1 "," $2 "," splitDate[1] "/" splitDate[2] "/" anneeBienFormatee) >> "bienFormaté.txt";
    }
}

BEGIN {
    FS=","
}


