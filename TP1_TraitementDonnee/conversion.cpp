#include <iostream>
#include <fstream>
#include <string>

 
int main(int argc, char ** argv)
{

if(argc == 4)    //./conversion latin1 utf8 text.latin1.txt > output.txt
{
        std::string encode_FROM = argv[1];
        std::string encode_TO = argv[2];
        std::string encode_INPUT = argv[3];

        std::ifstream fic(encode_INPUT, std::ios::binary);
    
        if(fic){    //On vérifie que le fichier existe

            char c;
            int count = 1;  //Compte le nb d'octet (pour utf8)

                if(encode_FROM == "latin1" && encode_TO == "utf8")
                {
                    while(!fic.eof())
                    {
                        count = 1;
                        fic.get(c);
                        std::cout<<c;

                        //Ici on compte le nombre de bits de points forts pour déterminer le nb d'octets

                        if((c & 0b11100000) == 0b11000000) count = 2;
                        else if((c & 0b11110000) == 0b11100000) count = 3; 
                        else if((c & 0b11111000) == 0b11110000) count = 4; 

                        for(int j = 1; j<count; ++j)
                        {
                            fic.get(c);
                            
                            if((c & 0b11000000) == 0b11000000) c= (c & 0b10111111);

                            c = ((c & 0b00111111) | 0b10000000); //J'applique les bits "10" de points forts afin de transformer en UTF8
                            std::cout<<c;
                        }
                    }
                }

                else if (encode_FROM == "utf8" && encode_TO == "latin1")
                {   
                    while(!fic.eof())
                    {
                        count = 1;
                        fic.get(c);

                        //Ici on compte le nombre de bits de points forts pour déterminer le nb d'octets

                        if((c & 0b11100000) == 0b11000000) count = 2;
                        else if((c & 0b11110000) == 0b11100000) count = 3; 
                        else if((c & 0b11111000) == 0b11110000) count = 4; 
        
                        std::cout<<c;    

                        for(int j = 1; j<count; ++j)
                        {
                            fic.get(c); //on passe tout les bits "complémentaires" de l'UTF8
                        }
                    }
                }

                else if (encode_FROM == encode_TO)
                {    
                    while(!fic.eof())
                    {
                        fic.get(c);
                        std::cout<<c;
                    }
                }

                else std::cout<<"encodage demandé inconnu";

            fic.close();
        }
        
        else std::cout<<"Impossible d'ouvrir le(s) fichier(s) demandé(s)";
    }

    
    return 0;
}
