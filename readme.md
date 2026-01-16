# 🚀 Guía de Despliegue Local (Minikube)

Sigue estos pasos para levantar el proyecto en tu máquina local usando Minikube y Docker.

### 1. Prerrequisitos
Tener instalado Docker y Minikube.

Para instalar Minikube con Chocolatey:

```bash
choco install minikube
```

Si es tu primera vez, inicia el cluster con el driver de Docker:

```bash
minikube start --driver=docker
```
### 2. Construir la Imagen Docker
Es necesario construir la imagen y, muy importante, cargarla dentro de Minikube para que el cluster la reconozca (ya que Minikube no ve tus imágenes locales por defecto).

#### Construir la imagen localmente
```bash
docker build -t mickey-mouse:v1 .
```

#### Cargar la imagen al entorno de Minikube
```bash
minikube image load mickey-mouse:v1
```
### 3. Configurar Ingress (Solo una vez)
Este proyecto utiliza un Ingress para asignar un dominio local. Debes activar el addon en Minikube:
```bash
minikube addons enable ingress
```
### 4. Desplegar en Kubernetes
Aplica los archivos de configuración para crear el Deployment, el Service y el Ingress.
```bash

# Aplicar la configuración del Deployment y Servicio
kubectl apply -f todo-k8s.yaml

```
### 5. Exponer el Cluster (Necesario en Windows/Mac)
Para que la dirección IP del Ingress sea accesible desde tu host, necesitas crear un túnel. Mantén esta terminal abierta.

```bash
minikube tunnel
```
### 6. Configuración de DNS Local
Para acceder mediante el dominio mickey.local, añade la siguiente línea a tu archivo de hosts:
```bash
Windows: C:\Windows\System32\drivers\etc\hosts
```
```bash
Linux/Mac: /etc/hosts
```
```bash
127.0.0.1 mickey.local
```
### 7. Probar
Abre tu navegador y visita: http://mickey.local