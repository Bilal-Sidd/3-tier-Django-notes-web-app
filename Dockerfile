FROM python:3.9-slim

WORKDIR /app/backend

COPY requirements.txt /app/backend
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*


# Install app dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/backend

EXPOSE 8000
# Wait for the database to be ready and then start the application
CMD sh -c "until mysql -h db -u root -proot -e 'select 1'; do echo waiting for db; sleep 2; done && python manage.py migrate --noinput && gunicorn notesapp.wsgi --bind 0.0.0.0:8000"

CMD python /app/backend/manage.py runserver 0.0.0.0:8000
#RUN python manage.py migrate
#RUN python manage.py makemigrations
