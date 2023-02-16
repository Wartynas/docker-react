# beginning of build phase
FROM node:16-alpine AS builder
WORKDIR 'app/'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# beginning of run phase (no need to explicitly stop phase 1 because a single phase can only have a single FROM statement)
FROM nginx AS runner
# this is needed for Elastic Beanstalk (only for production, in the development it is not needed)
EXPOSE 80 
COPY --from=builder /app/build /usr/share/nginx/html
# no need to specify default command, because it starts nginx without asking specifically.