FROM sprysio/python_agent:python

WORKDIR /myapp

COPY /myapp .

USER root

# Install required packages and create virtual environment
#RUN python3 -m venv venv && source venv/bin/activate 
RUN pip install --no-cache-dir -r requirements.txt --break-system-packages

USER jenkins

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s \ 
            --retries=3 CMD [ "python3", "hello.py" ]

ENTRYPOINT ["/bin/bash", "-c", "exec \"$@\"", "--"]