FROM sprysio/python_agent:python

# Create a non-root user and set the home directory
RUN useradd -m myappuser

# Set the working directory
WORKDIR /myapp

# Copy the application files
COPY . .

# Change ownership of the application files to the non-root user
RUN chown -R myappuser:myappuser /myapp

# Switch to the non-root user
USER myappuser

# Create the virtual environment and install dependencies
RUN python3 -m venv venv \
    && . venv/bin/activate \
    && pip install -r requirements.txt

# Define health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s \
            --retries=3 CMD [ "python3", "hello.py" ]

# Set the entrypoint
ENTRYPOINT ["/bin/bash", "-c", ". venv/bin/activate && exec \"$@\"", "--"]
