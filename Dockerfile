FROM mcp/node-code-sandbox AS build

# RUN addgroup -g 1000 appgroup && \
#     adduser -u 1000 -G appgroup -D appuser

# USER appuser

WORKDIR /app

# COPY --chown=appuser:appgroup . .

COPY . . 


RUN npm i


RUN npm run build

FROM nginxinc/nginx-unprivileged

COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]