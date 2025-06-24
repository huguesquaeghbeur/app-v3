FROM node:24-alpine AS build

WORKDIR /app

COPY package.json ./

RUN npm i

COPY . . 

RUN npm run build

FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]