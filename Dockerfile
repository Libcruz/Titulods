# Usa la imagen base de Nginx
FROM nginx:latest

# Información de la persona (modifica estas variables con tus datos)
ENV STUDENT_NAME="LibniCruzSantos"
ENV STUDENT_ID="2024480"

# Nombre de la carpeta personal
ENV PERSONAL_FOLDER="${STUDENT_NAME}-${STUDENT_ID}"

# Crea la carpeta personal en la raíz del sistema
RUN mkdir -p /${PERSONAL_FOLDER}

# Asigna permisos necesarios
RUN chmod 777 /${PERSONAL_FOLDER}

# Copia los recursos de Examen dentro de la carpeta personal (asegúrate de que la carpeta 'recursos' esté en el mismo directorio que el Dockerfile)
COPY recursos /${PERSONAL_FOLDER}/recursos

# Instala las tecnologías necesarias (ejemplo con PHP)
RUN apt-get update && \
    apt-get install -y php-fpm

# Configura Nginx para utilizar PHP
RUN echo 'server {\n\
    listen 80;\n\
    server_name localhost;\n\
    root /usr/share/nginx/html;\n\
    index index.php index.html index.htm;\n\
    location ~ \.php$ {\n\
        include snippets/fastcgi-php.conf;\n\
        fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;\n\
    }\n\
    location / {\n\
        try_files $uri $uri/ =404;\n\
    }\n\
}' > /etc/nginx/conf.d/default.conf

# Copia el sitio web dentro del contenedor (asegúrate de que el sitio web esté en la carpeta 'recursos')
COPY recursos /usr/share/nginx/html

# Exponer el puerto 80
EXPOSE 80

# Inicia Nginx
CMD ["nginx", "-g", "daemon off;"]
