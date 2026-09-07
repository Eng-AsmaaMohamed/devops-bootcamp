# Purpose: Define how to build the Docker image for the Node.js application.

# Use the official Node.js image as the base image
FROM node

# Set /app as the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json first.
# This allows Docker to reuse the dependency-installation layer
# when the application source code changes.
COPY package*.json ./

# Install the application dependencies
RUN npm install

#Docker layer caching وبيخلي الـ builds أسرع.
#لأن Docker بيعمل layers.
#فلو غيرتي src/index.js مثلًا، Docker يقدر يستخدم الـ cached layer بتاعة
#ومش يضطر يعمل npm install من جديد طالما package.json وpackage-lock.json ما اتغيروش.

# Copy the application source code into the container
COPY . .

# Document the port used by the Node.js application
EXPOSE 4000

# Start the application using the start-dev script from package.json
CMD ["npm", "run", "start-dev"]