#!/bin/bash

for target in telepod-without-center telepod-with-center only-center
do
	echo ${target}
	openscad -q -o ${target}.stl -p parameters.json -P ${target} telepod.scad
done


