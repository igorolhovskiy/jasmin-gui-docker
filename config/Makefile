PYTHON := python
PIP := python -m pip
MANAGE := python ./manage.py

default:
	$(error Invalid target)

gunicorn: migrate static
	gunicorn \
		--access-logfile - \
		--bind 0.0.0.0:8000 \
		--backlog 100 \
		--chdir /app \
		--error-logfile - \
		--preload \
		--workers 32 \
		main.wsgi

migrate:
	${MANAGE} makemigrations
	${MANAGE} migrate --noinput

static:
	${MANAGE} collectstatic --noinput
