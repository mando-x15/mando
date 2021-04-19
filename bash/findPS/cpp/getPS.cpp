#include <iostream>
#include <fstream>
#include <algorithm>
#include <cstdlib>

using namespace std;

int main(int argc, char** argv){

if(argc != 3) {cout << argv[0] << " FileName Column" << std::endl; return -1; }

double col1, col2, col3, col4 = 0;
double col4_max = 0, col4_prev = 0;
double time=0;
const char* fname;
const char* col;

if(argc == 3){
    fname = argv[1];
    col = argv[2];
}

ifstream f_in;

f_in.open(fname);

//discard first line
    f_in >> col1 >> col2 >> col3 >> col4;

col1 = 0, col2 = 0, col3 = 0, col4 = 0;

while(!f_in.eof())
{
    //input data
    f_in >> col1 >> col2 >> col3 >> col4;

    //find max
    if ( max(col4,col4_prev) == col4 ) {
            if ( max(col4,col4_max) == col4) {
                col4_max = col4;
                time = col1;
            }
    }

    col4_prev = col4;

}

cout << time << "  " << col4_max << endl;

f_in.close();

return 0;



}
