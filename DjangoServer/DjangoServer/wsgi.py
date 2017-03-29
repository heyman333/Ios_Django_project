"""
WSGI config for DjangoServer project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/1.8/howto/deployment/wsgi/
"""

import os
import sys
sys.path.append('/home/ubuntu/Ios_Django_project/DjangoServer')
os.environ['DJANGO_SETTINGS_MODULE'] = 'DjangoServer.settings'
from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()
