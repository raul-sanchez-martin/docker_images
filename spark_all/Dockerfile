FROM ubuntu:16.04

MAINTAINER Raul Sanchez Martin

# Set working directory in /
WORKDIR /

# Install pip
RUN apt-get update 
RUN apt-get install -y python3-pip 
RUN pip3 install --upgrade pip 
# RUN apt-get install -y python-pip 
# RUN pip install --upgrade pip 
RUN apt-get install -y python-setuptools python-dev

# Install libgtk2.0 neccesary for openfv (Python library)
RUN apt-get install libgtk2.0-dev -y

# Install thinker
RUN apt-get install -y python3-tk

# Install tesseract & imagemagick
RUN apt-get install -y tesseract-ocr
RUN apt-get install -y tesseract-ocr-spa
RUN apt-get install -y imagemagick

RUN mkdir /software
RUN mkdir /working_directory
RUN mkdir /environments

RUN apt-get install virtualenv python-virtualenv -y
RUN cd /environments && virtualenv general_env --python=/usr/bin/python3

# Add and install requirements
ADD requirements.txt /requirements.txt
RUN [ "/bin/bash", "-c", "source /environments/general_env/bin/activate && pip3 install -r requirements.txt"]

# Install & configure Java
RUN apt-get update && apt-get install software-properties-common -y
RUN add-apt-repository ppa:webupd8team/java
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get update
RUN apt-get install oracle-java8-installer -y
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV JRE_HOME /usr/lib/jvm/java-8-oracle/jre
ENV PATH "${PATH}:${JAVA_HOME}"
ENV PATH "${PATH}:${JRE_HOME}"

# Install & configure Scala
# ENV SCALA_VERSION 2.12.4
ENV SCALA_VERSION 2.11.8
# ENV SCALA_VERSION 2.11.11
RUN curl -fsL https://downloads.lightbend.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /software/
ENV SCALA_HOME /software/scala-$SCALA_VERSION
ENV PATH "${PATH}:${SCALA_HOME}/bin"

# Install & configure Spark
# ENV SPARK_VERSION 2.2.0
ENV SPARK_VERSION 2.1.0
# ENV SPARK_VERSION 2.0.2
RUN curl -fsL https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop2.7.tgz | tar xfz - -C /software/
ENV SPARK_HOME /software/spark-$SPARK_VERSION-bin-hadoop2.7
ENV PATH "${PATH}:${SPARK_HOME}/bin"

ADD start_notebook.sh /working_directory/start_notebook.sh

WORKDIR /working_directory
RUN chmod +x /working_directory/start_notebook.sh

EXPOSE 8080

ENV SHELL /bin/bash

CMD ["/bin/bash", "-c", "/working_directory/start_notebook.sh"]
