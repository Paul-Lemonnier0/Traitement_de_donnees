NR == 1 {
    printf("il y a " $2 " fichiers ");
}

NR != 1 {
    nbOctetsTotal = $5;
}

BEGIN {
    nbOctetsTotal = 0;
}

END {
    print("pour un total de " nbOctetsTotal " octets.");
}