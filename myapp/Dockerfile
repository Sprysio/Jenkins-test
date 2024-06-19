FROM sprysio/python_agent:python

WORKDIR /myapp

COPY . .

USER root

RUN python3 -m venv /myapp/venv 
RUN /myapp/venv/bin/pip install --no-cache-dir -r /myapp/requirements.txt

USER jenkins

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s \ 
            --retries=3 CMD [ "python3", "hello.py" ]

ENTRYPOINT ["/bin/bash", "-c", ". /myapp/venv/bin/activate && exec \"$@\"", "--"]