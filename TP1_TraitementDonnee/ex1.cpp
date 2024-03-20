#include <iostream>
#include <fstream>
 
int main(int argc, char ** argv)
{
    for(int i = 1; i<argc; ++i)
    {
        std::ifstream fic(argv[i], std::ios::binary);
    
        if(fic) {
            
            int count = 1;
            bool isASCII = true;
            bool isUTF8 = true;
            char c;

            while(!fic.eof() && isUTF8)
            {
                fic >> c;
                if((c & 0b10000000) != 0b00000000) {
                    isASCII = false;
                    count = 1;

                    if((c & 0b11100000) == 0b11000000) count = 2;
                    else if((c & 0b11110000) == 0b11100000) count = 3; 
                    else if((c & 0b11111000) == 0b11110000) count = 4; 

                    for(int j = 1; j<count; ++j)
                    {
                        fic >> c;
                        if((c & 0b11000000) != 0b10000000) 
                            isUTF8 = false;
                    }
                }
            }

            if(isASCII) std::cout<<argv[i]<< " : "<< "ASCII" <<std::endl;
            else if(isUTF8) std::cout<<argv[i]<< " : "<< "UTF8" <<std::endl;
            else std::cout<<argv[i]<< " : " << "latin 1" <<std::endl;

            //std::cout<<" le charactère est : "<<c;
            fic.close();
        }
        
        else std::cout<<"Impossible d'ouvrir le(s) fichier(s) demandé(s)";
    }

    
    return 0;
}
