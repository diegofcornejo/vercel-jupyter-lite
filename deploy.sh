#!/bin/bash
set -e

# Install wget
yum install wget -y

# Download and extract Micromamba
wget -qO- https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba

# Set up environment variables
export MAMBA_ROOT_PREFIX="$PWD/micromamba"
export PATH="$PWD/bin:$PATH"

# Create the environment
micromamba create -n jupyterenv python=3.12 -c conda-forge -y

# Install dependencies via pip in the micromamba environment
micromamba run -n jupyterenv python -m pip install -r requirements.txt

# Build JupyterLite
micromamba run -n jupyterenv jupyter lite --version
micromamba run -n jupyterenv jupyter lite build --contents content --output-dir dist