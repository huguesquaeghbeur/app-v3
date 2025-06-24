FROM node:24-alpine AS build



WORKDIR /app


COPY . . 


RUN npm i


RUN addgroup -g 1001 appgroup && \
    adduser -u 1001 -G appgroup -D appuser

USER appuser

COPY --chown=appuser:appgroup . .

RUN npm run build

FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]