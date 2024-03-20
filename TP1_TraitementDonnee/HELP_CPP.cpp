#include <iostream>
#include <fstream>

int main(int argc, char ** argv)
{
    for(int i = 0; i<argc; ++i)
    {
        std::ifstream fic(argv[i], std::ios::binary);
        if(fic)
        {
            int count;
            char c;

            while(!fic.eof())
            {
                fic.get(c);

                if((c & 0b10000000) != 0b00000000) {}//Mask sur c => on check si c commence par un 1
                if((c & 0b11100000) == 0b11000000) count = 2; //check qu'il y est qlq chose comme : 11000000
                if((c & 0b11000000) != 0b10000000) {} //check bit de point fort 10

                if((c & 0b11000000) == 0b11000000) c= (c & 0b10111111); //on modifie le début de c de 11 en 10
                c = ((c & 0b00111111) | 0b10000000); //transformation de c en un debut de bit de points forts
            }

            fic.close();
        }

        else std::cout<<"Impossible d'ouvrir le fichier : "<<argv[i];
    }



    return 0;
}
