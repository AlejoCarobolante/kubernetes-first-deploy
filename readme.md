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

## 🔄 Automatización del Desarrollo (Dev Loop)

Para evitar ejecutar manualmente los comandos de build y deploy con cada cambio, este repositorio incluye dos formas de automatizar el flujo de trabajo.

### Opción 1: Script de PowerShell (Sencillo)
Este script (`deploy.ps1`) automatiza la construcción de la imagen, la carga en Minikube y el reinicio de los Pods.

**Uso:**
Simplemente ejecuta el script desde la raíz del proyecto cada vez que quieras actualizar tus cambios:

```bash
./deploy.ps1
```
*Nota*: Si tienes problemas de permisos para ejecutar scripts, puedes necesitar correr esto en PowerShell como Administrador: Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

### Opción 2: Skaffold (Avanzado / Hot Reload)
Skaffold observa tus archivos y detecta cambios en tiempo real. Cuando guardas un archivo, Skaffold automáticamente reconstruye la imagen y actualiza el cluster.

#### 1. Instalación
Si usas Windows y tienes Chocolatey, instala Skaffold con un solo comando:

```bash
choco install -y skaffold
```
(También puedes descargar el ejecutable directamente desde su web oficial).

#### 2. Ejecución
Para iniciar el modo de desarrollo continuo (Hot Reload):

```bash
skaffold dev

# La terminal se quedará "escuchando". Prueba cambiar algo en tu index.html y guarda el archivo; verás cómo se actualiza automáticamente en el navegador sin tocar nada más.
```

```bash
skaffold build

# Skaffold construye los artefactos (no se queda escuchando).
```

```bash
skaffold run

# Skaffold construye los artefactos y deployea la app.
```

Para detenerlo, simplemente presiona Ctrl + C en la terminal (esto también limpiará los recursos creados por Skaffold).