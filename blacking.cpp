#include "CImg.h"
#include <ctime>
#include <iostream>
#include <stdlib.h>
#include <string>
#include <vector>
#include <algorithm>
#include <math.h>
#include <float.h>

using namespace cimg_library;
using namespace std;

int main(int argc, char **argv)
{
    try 
    {
        if(argc < 3)
        {
            cout << "Insufficent number of arguments; correct usage:" << endl;
            cout << "    ./a.out *queryimage* ll/lr/rl/rr" << endl;
            return -1;
        }
        
        string inputFile = argv[1];
	string area = argv[2];
	bool p1,p2;
	if(area == "0")
	{
	    p1=false;
	    p2=false;
	}
	else if(area == "1")
        {
            p1=false;
            p2=true;
        }
	else if(area == "2")
        {
            p1=true;
            p2=false;
        }
	else if(area == "3")
        {
            p1=true;
            p2=true;
        }
	CImg<double> input_image(inputFile.c_str());
        //CImg<double> gray = input_image.get_RGBtoHSI().get_channel(2);
	int w = input_image._width, h = input_image._height;
	int bw=(((int)p2)*(w/2)), bh=(((int)p1)*(h/2));
	for(int i=0; i<(h/2); ++i)
	{
	    for(int j=0;j<(w/2); ++j)
	    {
		input_image(j+bw,i+bh,0,0)=0;
		input_image(j+bw,i+bh,0,1)=0;
		input_image(j+bw,i+bh,0,2)=0;
	    }
	}
	input_image.get_normalize(0, 255).save(inputFile.c_str());
	//cout << input_image._width << " " << input_image._height << endl;
    }
    catch(const string &err) 
    {
        cerr << "Error: " << err << endl;
    }
}
