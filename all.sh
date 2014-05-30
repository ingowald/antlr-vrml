#!/bin/bash

files=`find $1 -name '*wrl'`
mkdir /tmp/vrml.g4.out
for f in $files ; do
		echo "-------------------------------------------------------"
		echo testing file $f

		out=`basename $f.wrl`
		
		java org.antlr.v4.runtime.misc.TestRig vrml world < $f \
				> /tmp/vrml.g4.out/$out.out 2> /tmp/vrml.g4.out/$out.err
		if [ -s /tmp/vrml.g4.out/$out.err ] ; then
				echo "~~~~~~~~~~~~"
				echo "!!!FAILED!!!".
				echo "~~~~~~~~~~~~"
		cat /tmp/vrml.g4.out/$out.out
				cat /tmp/vrml.g4.out/$out.err
				exit 1
		fi
		echo OK.
		cat /tmp/vrml.g4.out/$out.out
done



