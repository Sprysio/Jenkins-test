FROM sprysio/python_agent:python

WORKDIR /myapp

COPY . .

USER root

# Install required packages and create virtual environment
RUN python3 -m venv /myapp/venv && \
    /myapp/venv/bin/python -m ensurepip && \
    /myapp/venv/bin/pip install --upgrade pip && \
    /myapp/venv/bin/pip install --no-cache-dir -r /myapp/requirements.txt
    
USER jenkins

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s \ 
            --retries=3 CMD [ "python3", "hello.py" ]

ENTRYPOINT ["/bin/bash", "-c", ". /myapp/venv/bin/activate && exec \"$@\"", "--"]