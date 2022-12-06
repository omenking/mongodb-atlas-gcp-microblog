FROM node:16.18

COPY . /frontend
WORKDIR /frontend
RUN npm install
EXPOSE 3000
CMD ["npm", "start"]