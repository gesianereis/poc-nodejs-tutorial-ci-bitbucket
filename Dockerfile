FROM node:8.9.4

RUN apt-get update -y

RUN mkdir /app

# Setup app working directory
WORKDIR /app

# Instalar e configurar ssh, copiar chave para acesso ao repositório bitbucket, fazer clone da branch dev do repositório e apagar a chave
RUN apt-get install openssh-server -y 
RUN echo Host bitbucket.org >> /etc/ssh/ssh_config
RUN echo      StrictHostKeyChecking no >> /etc/ssh/ssh_config
RUN /etc/init.d/ssh restart
COPY feliperovai.pem /home/
RUN chmod 600 /home/feliperovai.pem  
RUN ssh-agent bash -c 'ssh-add /home/feliperovai.pem; git clone --branch dev git@bitbucket.org:suporte_concrete/all-ways-dev.git'
RUN rm /home/feliperovai.pem

# Setar local de trabalho para dentro do repositório clonado e instalar todas dependencias do node
WORKDIR /app/all-ways-dev/
#ENV NODE_ENV='development'
#ENV PORT='3000''
#ENV DB_URL'

RUN npm install


# Expor porta da api
EXPOSE 3000

# Start app
CMD [ "npm", "start"]

