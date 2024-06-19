FROM sprysio/python_agent:python

WORKDIR /myapp

COPY . .

USER root

RUN python3 -m venv venv 
RUN . venv/bin/activate && pip install -r requirements.txt

USER jenkins

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s \ 
            --retries=3 CMD [ "python3", "hello.py" ]

ENTRYPOINT ["/bin/bash", "-c", ". venv/bin/activate && exec \"$@\"", "--"]