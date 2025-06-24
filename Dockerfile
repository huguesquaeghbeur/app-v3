FROM node:24-alpine AS build


USER appuser

WORKDIR /app

RUN mkdir -p /app && chown -R appuser:appgroup /app

COPY . . 


RUN npm i


COPY --chown=appuser:appgroup . .

RUN npm run build

FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]