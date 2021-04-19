#! /usr/bin/python


# set filename
filename= 'energy.txt'

# open output files
#outfilename = 'out.txt';
#outfile = open(outfilename, 'w')

# open file, find number of lines
infile1 = open(filename, "r");
num_lines = sum(1 for l in infile1)
infile1.close()

#sort data -- extract column 9 in AllEta.dat
data = []
infile1 = open(filename, "r");
line = infile1.readline()
for x in xrange(1,num_lines):
	line = infile1.readline()
	row = [float(each) for each in line.split()]
	data.append(row[3])

infile1.close()

#find max/min
print data.index(max(data))+2-6, max(data)

#outfile.write(str(data.index(max(data))+1))
#outfile.write(" ")
#outfile.write(str(max(data)))
#outfile.write("\n")
#outfile.close()

