# First we pull the base image from DockerHub
FROM amazon/aws-lambda-provided:al2

# Copy our bootstrap and make it executable
WORKDIR /var/runtime/
COPY bootstrap bootstrap

RUN yum install iputils -y

# Copy our function code and make it executable
WORKDIR /var/task/
COPY . .

#Seting up Uitility PATH
ENV JAVA_HOME /var/task/java-11
ENV PATH=$JAVA_HOME/bin:$PATH
RUN export JAVA_HOME
RUN export PATH

ENV PATH=/var/task/dist:$PATH
RUN export PATH
ENV PATH=$HOME/:$PATH
RUN export PATH

#
ENV MAX_MSG=10


# Set the handler
# by convention <fileName>.<handlerName>
CMD [ "function.sh.handler" ]