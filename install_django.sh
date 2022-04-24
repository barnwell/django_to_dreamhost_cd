#!/bin/bash

python_path="$HOME"/opt/python-3.10.1/bin/
venv_dir=venv

echo "### Adding $python_path to PATH"
export PATH=$python_path:$PATH

echo "### Setting up venv..."
virtualenv -p "$python_path"/python3 $venv_dir
source $venv_dir/bin/activate

echo "### Installing Dependencies..."
pip install -r requirements.txt

echo "### Setting up database..."
python manage.py makemigrations
python manage.py migrate

echo "### Generate Static Files..."
python manage.py collectstatic --noinput

echo "### Start Server..."
mkdir -p tmp
touch tmp/restart.txt

echo "Done!"
