all:
	make jenkins

jenkins:
	/bin/bash build.sh
	find . -iname '*.rpm' | sort

