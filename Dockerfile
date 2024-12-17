# Escolha uma imagem base
FROM nginx:alpine

# Copie código para o diretório de conteúdo do Nginx
COPY src/ /usr/share/nginx/html/

# Exponha a porta 80 para acessar o serviço
EXPOSE 80

# Comando padrão para rodar o Nginx em primeiro plano
CMD ["nginx", "-g", "daemon off;"]
