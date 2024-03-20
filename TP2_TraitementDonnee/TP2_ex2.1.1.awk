NF > 0 {
    
    for(i = 1; i<=NF; ++i)
    {
        if(i == 1) printf toupper(substr($i,0,1)) tolower(substr($i,2)) " "

        else if(toupper(substr($i,0,1)) == substr($i,0,1) || i == NF)
        {
            printf toupper($i) " "
        }

        else printf toupper(substr($i,0,1)) tolower(substr($i,2)) " "
    }

    print "";
}

BEGIN {
    FS=" "
}