#!/bin/bash


echo "Cleaning up..."
echo ""

cd data
	rm -f *
cd ..

cd distances
	rm -f *.txt
cd ..

cd logs
	rm -f *.log
cd ..


