FROM node:24-alpine AS build



WORKDIR /app


COPY . . 


RUN npm i


RUN adduser -u 1001:1001 appuser

USER appuser

COPY --chown=appuser:appgroup . .

RUN npm run build

FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]