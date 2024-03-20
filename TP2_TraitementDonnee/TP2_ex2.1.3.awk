BEGIN {
    FS=","
}

NF > 0 {
    nombrePrenoms = split($1, prenoms, " ");
    if(nombrePrenoms > 1)
    {
        for(i=1; i<=nombrePrenoms; ++i)
        {
            printf(toupper(substr(prenoms[i],0,1)) tolower(substr(prenoms[i],2)) " ")
        }
    }

    else {
        nombrePrenoms = split($1, prenoms, "-");

        for(i=1; i<=nombrePrenoms; ++i)
        {
            printf(toupper(substr(prenoms[i],0,1)) tolower(substr(prenoms[i],2)))
            
            if(i!=nombrePrenoms) printf("-")
            else printf(" ")
        }
    }

    print toupper($2)
}