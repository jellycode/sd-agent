#!/bin/bash
set -ev

git clone https://github.com/serverdensity/hokaben.git
cd hokaben
python2 bootstrap.py
bin/buildout
bin/build -r https://github.com/serverdensity/sd-agent.git
ls WORKAREA/src/
ls WORKAREA/src/sd-agent
