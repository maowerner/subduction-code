#!/bin/bash
# Copyright © 2017-2018 Martin Ueding <dev@martin-ueding.de>
# Modified by Markus Werner <markus.werner@uni-bonn.de>
# Licensed under the MIT/Expat license.

set -e
set -u
set -x

sourcedir="$(pwd)"
outdir="$HOME/output"

cd ..

###############################################################################
#                              Install Packages                               #
###############################################################################

ubuntu_packages=(
  libhdf5-dev
)

sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install -y "${ubuntu_packages[@]}"

python -c 'import sys; print sys.path'

##########################################################################################
# Setup                                                                     #
##########################################################################################


# Set up output folder
mkdir -p "$outdir/integration/3_gevp-data"
cp "$sourcedir/tests/integration/p"*".ini" "$outdir/integration/3_gevp-data/"

# Set up input data
mkdir -p "$HOME/Data/A40.24"
pushd "$sourcedir"
chmod +x travis-ci_setup.py
python travis-ci_setup.py
popd

##########################################################################################
# Run tests                                                                              #
##########################################################################################

pushd "$sourcedir"
python analyse tests/integration/A40.24.ini -vv -b marcus-con
popd
