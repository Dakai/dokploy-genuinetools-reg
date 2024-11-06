# Use an official Go runtime as a parent image
FROM golang:latest

# Set the working directory in the container
WORKDIR /app

# Install reg
RUN go install github.com/genuinetools/reg@latest

# Create a script to run reg with environment variables
RUN echo '#!/bin/sh' > run_reg.sh && \
    echo 'reg -u $USERNAME -p $PASSWORD -r $REGISTRY_URL' >> run_reg.sh && \
    chmod +x run_reg.sh

# Set the entrypoint to the script
ENTRYPOINT ["./run_reg.sh"]
