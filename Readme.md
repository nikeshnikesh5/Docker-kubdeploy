# 🚀 Multi-Stage Docker Build (Node.js)

## 📌 Overview
This project uses a **multi-stage Docker build** to:
- Reduce image size
- Improve security
- Separate build and runtime environments

---

## 🧠 Concept

- **Stage 1 (Build)** → Install full dependencies & prepare app  
- **Stage 2 (Run)** → Use clean image with only required files  

---

## 🏗️ Dockerfile

```dockerfile
# Stage 1: Build
FROM node:20-alpine AS build

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .

# Stage 2: Run
FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install --production

COPY --from=build /app ./

EXPOSE 3000

CMD ["npm", "start"]





# 🧱 Deployment YAML

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: simple-node-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: simple-node
  template:
    metadata:
      labels:
        app: simple-node
    spec:
      containers:
      - name: simple-node
        image: techhunt/simple-node:latest
        ports:
        - containerPort: 3000








                🌍 User (Browser)
               │
               ▼
   http://NodeIP:30007
               │
        ┌───────────────┐
        │   NodePort    │ 30007
        └──────┬────────┘
               │
        ┌──────▼────────┐
        │   Service     │ port 3000
        └──────┬────────┘
               │
     ┌─────────▼─────────┐
     │       Pods        │ (2 replicas)
     │  app: simple-node│
     └─────────┬─────────┘
               │
        ┌──────▼────────┐
        │  Container    │ port 3000
        └───────────────┘