#!/bin/bash

# Verificar errores y detener el script si alguno ocurre
set -e

# Almacenar el directorio actual
ORIGINAL_DIR=$(pwd)

echo "🚀 Iniciando Minikube con 3 nodos..."
minikube start --nodes 3 --memory=2048 --cpus=2 --driver=virtualbox

echo "✅ Minikube iniciado. Verificando nodos..."
kubectl get nodes

echo "🌐 Descargando Istio..."
curl -L https://istio.io/downloadIstio | sh -

# Extraer versión descargada automáticamente
ISTIO_VERSION=$(ls | grep istio-)
cd $ISTIO_VERSION

echo "🔧 Configurando PATH para Istio..."
export PATH=$PWD/bin:$PATH

echo "🛠 Instalando Istio con perfil demo..."
istioctl install --set profile=demo -y

echo "⏳ Esperando que los pods de Istio se inicien..."
kubectl wait --for=condition=Ready pods --all -n istio-system --timeout=300s

echo "✅ Istio instalado. Verificando pods en el namespace 'istio-system'..."
kubectl get pods -n istio-system

echo "⏳ Esperando 5 segundos antes de aplicar el archivo YAML..."
sleep 5

# Regresar al directorio original
cd $ORIGINAL_DIR

# Mostrar el directorio actual
echo "📂 Directorio actual: $(pwd)"

# Verificar si el archivo existe antes de aplicar
if [[ -f production-pod.yaml ]]; then
    echo "📋 Creando recursos desde 'production-pod.yaml'..."
    kubectl apply -f production-pod.yaml
    echo "✅ Recursos aplicados con éxito."
else
    echo "❌ El archivo 'production-pod.yaml' no se encontró."
    exit 1
fi

echo "🎉 Configuración completa. Recursos aplicados:"

# Bucle para verificar que todos los pods estén en Running
while true; do
    clear
    echo "🔄 Verificando estado de los pods y deployments..."
    
    # Mostrar el estado de todos los recursos
    kubectl get all

    # Obtener el estado de los pods
    PODS_STATUS=$(kubectl get pods --no-headers | awk '{print $3}' | grep -v "Running") # Excluye los que están en Running

    # Comprobar si todos los pods están en Running
    if [[ -z "$PODS_STATUS" ]]; then
        echo "✅ Todos los pods están en Running."
        break
    else
        echo "🔄 Esperando que los pods estén en Running..."
    fi

    sleep 3
done

# Bucle para verificar que todos los deployments estén disponibles
while true; do
    clear
    echo "🔄 Verificando estado de los deployments..."
    
    # Mostrar el estado de todos los recursos
    kubectl get all

    # Obtener el estado de los deployments
    DEPLOYMENTS_STATUS=$(kubectl get deployments --no-headers | awk '{print $4}' | grep -v "1") # Excluye los que no están listos

    # Comprobar si todos los deployments están disponibles
    if [[ -z "$DEPLOYMENTS_STATUS" ]]; then
        echo "✅ Todos los deployments están disponibles."
        break
    else
        echo "🔄 Esperando que los deployments estén disponibles..."
    fi

    sleep 3
done
