#!/bin/bash

# Criar um armazenador em nuvem


# Instalando pacotes necessários para armazenamento em nuvem
sudo apt-get install s3cmd s3fs davfs2 -y

# Criando um bucket S3 e configurando-o para uso
s3cmd mb s3://my-bucket-name
s3cmd --configure

# Mountando o bucket S3 no sistema de arquivos
s3fs my-bucket-name /mnt/my-bucket-name -o allow_other -o use_cache=/tmp -o uid=1000 -o mp_umask=002 -o multireq_max=5

# Criando um ponto de montagem WebDAV e configurando-o para uso
sudo mkdir /mnt/mywebdav
sudo chown $USER:$USER /mnt/mywebdav
davfs2 mywebdav.example.com /mnt/mywebdav -o uid=$USER -o gid=$USER
echo "https://mywebdav.example.com /mnt/mywebdav davfs user,noauto 0 0" | sudo tee -a /etc/fstab 
mount /mnt/mywebdav

 echo "Armazenamento em nuvem configurado com sucesso."
