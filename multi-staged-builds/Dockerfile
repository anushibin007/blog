# Start with pulling an Ubuntu image
# Name this build stage as tempstage
FROM ubuntu:latest AS tempstage

# We will work inside the /tmp folder
WORKDIR /tmp

# Copy the tarball as downloaded from the Oracle website
COPY jdk-8u181-linux-i586.tar.gz .

# Extract it
RUN tar -xvf jdk-8u181-linux-i586.tar.gz

# --------------- End of stage 1. Stage 2 starts --------------- #

# Start this one too by pulling an Ubuntu image.
# Name this build stage as mainstage
FROM ubuntu:latest AS mainstage

# Copy the extracted files from the "tempstage" build stage
COPY --from=tempstage /tmp/jdk1.8.0_181 /opt/jdk1.8.0_181
