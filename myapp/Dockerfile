FROM sprysio/python_agent:python

RUN python3 -m venv venv
 
RUN source venv/bin/activate

RUN pip install -r requirements.txt

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s \ 
            --retries=3 CMD [ "python3 hello.py" ]

RUN sh python3 hello.py --name=Forsen