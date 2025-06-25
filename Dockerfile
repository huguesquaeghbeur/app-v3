# Étape 1 : Build de l'application
FROM node:24-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
 
# Étape 2 : Image de production compatible OpenShift
FROM nginx:alpine
 
# Copie des fichiers buildés
COPY --from=build /app/dist /usr/share/nginx/html
 
# Donne les droits à l'utilisateur non root (OpenShift) sur tous les dossiers nécessaires
RUN chown -R 1001:0 /usr/share/nginx /var/cache/nginx /var/run /etc/nginx
 
# Change le port d'écoute de nginx (OpenShift utilise 8080 par défaut)
RUN sed -i 's/listen\s\+80;/listen 8080;/' /etc/nginx/conf.d/default.conf
 
# Utilise l'utilisateur non root par défaut d'OpenShift
USER 1001
 
EXPOSE 8080
 
CMD ["nginx", "-g", "daemon off;"]