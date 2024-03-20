BEGIN {
    FS=" "
}

NF > 0 {
    print toupper(substr($1,0,1)) tolower(substr($1,2)) " " toupper($2)
}