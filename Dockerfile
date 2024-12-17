# Escolha uma imagem base
FROM nginx:alpine

# Copie um arquivo HTML simples para o diretório de conteúdo do Nginx
COPY index.html /usr/share/nginx/html/index.html
COPY version.json /usr/share/nginx/html/image-version.json

# Exponha a porta 80 para acessar o serviço
EXPOSE 80

# Comando padrão para rodar o Nginx em primeiro plano
CMD ["nginx", "-g", "daemon off;"]
