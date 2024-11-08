# Use an official Go runtime as a parent image
FROM golang:latest

ARG USERNAME
ARG PASSWORD
ARG REGISTRY_URL
ARG PORT_NUMBER

# Set the working directory in the container
WORKDIR /app

#RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/genuinetools/reg .

# Install reg
RUN go install .

EXPOSE ${PORT_NUMBER}

#CMD ["reg","server","-u","${USERNAME}","-p","${PASSWORD}","-r","${REGISTRY_URL}","--port","${PORT_NUMBER}"]

# Create a script to run reg with environment variables
RUN echo '#!/bin/sh' > run_reg.sh && \
    echo "reg server -u ${USERNAME} -p ${PASSWORD} -r ${REGISTRY_URL} --port ${PORT_NUMBER}" >> run_reg.sh && \
    chmod +x run_reg.sh

#EXPOSE ${PORT_NUMBER}}
# Set the entrypoint to the script
#ENTRYPOINT ["./run_reg.sh"]
CMD ["./run_reg.sh"]
