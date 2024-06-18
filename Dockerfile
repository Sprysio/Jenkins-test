FROM sprysio/python_agent:python

WORKDIR /myapp

COPY myapp .

RUN python3 -m venv venv \
    && . venv/bin/activate \
    && pip install -r myapp/requirements.txt

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s \ 
            --retries=3 CMD [ "python3", "hello.py" ]

#CMD [ "sh", "-c", ". venv/bin/activate && python3 hello.py --name=Forsen" ]