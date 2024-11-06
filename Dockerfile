# Use an official Go runtime as a parent image
FROM golang:latest

# Set the working directory in the container
WORKDIR /app

#RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/genuinetools/reg .

# Install reg
RUN go install .

# Create a script to run reg with environment variables
RUN echo '#!/bin/sh' > run_reg.sh && \
    echo 'reg server -u $USERNAME -p $PASSWORD -r $REGISTRY_URL --port PORT_NUMBER' >> run_reg.sh && \
    chmod +x run_reg.sh

# Set the entrypoint to the script
ENTRYPOINT ["./run_reg.sh"]
