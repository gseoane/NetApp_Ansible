FROM python:3.10-slim

# Establece el directorio de trabajo
WORKDIR /ansible

# Actualiza el sistema e instala dependencias
RUN apt-get update && apt-get install -y \
    git \
    sshpass \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instala Ansible
RUN pip install --no-cache-dir ansible

# Instala los módulos de NetApp para Ansible (collection oficial)
RUN ansible-galaxy collection install netapp.ontap

# Dependencias adicionales para módulos de NetApp
RUN pip install --no-cache-dir \
    netapp-lib \
    requests \
    xmltodict \
    jmespath

# Por si quieres copiar tus playbooks dentro de la imagen (opcional)
# COPY ./playbooks /ansible/playbooks

# Comando por defecto
CMD [ "bash" ]
