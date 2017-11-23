#!/bin/bash

docker run --rm -i -t --name ${PWD##*/} senyor/${PWD##*/}:latest  /bin/bash

