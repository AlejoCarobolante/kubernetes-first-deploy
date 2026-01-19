docker build -t mickey-mouse:latest .
minikube image load mickey-mouse:latest
kubectl apply -f todo-k8s.yaml
kubectl rollout restart deployment/hola-mundo-deploy