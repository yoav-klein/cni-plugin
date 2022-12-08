
FROM python:3.9

RUN pip install -U pip
RUN pip install flask

RUN mkdir /app
COPY echo.py /app

CMD ["python3", "/app/echo.py"]
