import os
import sys

from django.core.wsgi import get_wsgi_application

cwd = os.getcwd()

INTERP = cwd + "/venv/bin/python3.10"
# INTERP is present twice so that the new python interpreter
# knows the actual executable path
if sys.executable != INTERP:
    os.execl(INTERP, INTERP, *sys.argv)

sys.path.append(cwd)

# Change this to the name of your Django project directory
sys.path.append(cwd + '/myproject')  

sys.path.insert(0, cwd + '/venv/bin')
sys.path.insert(0, cwd + '/venv/lib/python3.10.1/site-packages')

# Update this to point to your settings module for prod
os.environ['DJANGO_SETTINGS_MODULE'] = "config.settings.production"

application = get_wsgi_application()
