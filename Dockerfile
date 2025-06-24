FROM node:24-alpine AS build

# RUN addgroup -g 1000 appgroup && \
#     adduser -u 1000 -G appgroup -D appuser

# USER appuser

WORKDIR /app

# COPY --chown=appuser:appgroup . .

COPY . . 


RUN npm i


RUN npm run build

FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]