FROM ubuntu:16.04

MAINTAINER Raul Sanchez Martin

# Set working directory in /
WORKDIR /

# Install pip
RUN apt-get update 
# RUN apt-get install -y python3-pip 
# RUN pip3 install --upgrade pip 
RUN apt-get install -y python-pip 
RUN pip install --upgrade pip 
RUN apt-get install -y python-setuptools python-dev

# Install libgtk2.0 neccesary for openfv (Python library)
RUN apt-get install libgtk2.0-dev -y

# Install thinker
RUN apt-get install -y python3-tk

RUN mkdir /software
RUN mkdir /working_directory
RUN mkdir /environments

RUN apt-get install virtualenv python-virtualenv -y
RUN cd /environments && virtualenv general_env --python=/usr/bin/python2

# Add and install requirements
ADD requirements.txt /requirements.txt

RUN [ "/bin/bash", "-c", "source /environments/general_env/bin/activate && pip install -r requirements.txt"]

ADD hello.py /working_directory/hello.py

WORKDIR /working_directory

EXPOSE 8080

CMD ["/bin/bash", "-c", "source /environments/general_env/bin/activate && python hello.py"]
