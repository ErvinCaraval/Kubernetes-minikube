

```markdown
# Guía para Levantar un Clúster de Kubernetes con Minikube y Desplegar una Aplicación

## Introducción

Este documento proporciona una guía paso a paso para levantar un clúster de Kubernetes en tu máquina local usando Minikube, y para desplegar una aplicación de ejemplo con Kubernetes.

## Requisitos Previos

- **Minikube**: Debes tener Minikube instalado en tu máquina. Puedes instalarlo siguiendo las instrucciones en [Minikube Installation](https://minikube.sigs.k8s.io/docs/start/).
- **kubectl**: La herramienta de línea de comandos de Kubernetes debe estar instalada. Asegúrate de tener una versión compatible con tu clúster de Minikube. Puedes instalarla siguiendo las instrucciones en [kubectl Installation](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

## 1. Iniciar Minikube

Inicia Minikube usando el siguiente comando:

```bash
minikube start
```

Este comando iniciará un clúster de Kubernetes local usando Minikube. La salida esperada debería indicar que Minikube ha creado el clúster y configurado `kubectl` para usarlo.

## 2. Configurar el Túnel de Minikube

Para exponer servicios tipo `LoadBalancer`, necesitas iniciar un túnel:

```bash
sudo minikube tunnel
```

Introduce tu contraseña cuando se te solicite. Esto creará una ruta para los servicios tipo `LoadBalancer` y proporcionará una IP externa para acceder a ellos.

## 3. Crear Archivos de Configuración de Kubernetes

### `deployment.yaml`

Crea un archivo `deployment.yaml` 

### `service.yaml`

Crea un archivo `service.yaml` 

## 4. Aplicar la Configuración de Kubernetes

Aplica los archivos de configuración al clúster de Kubernetes:

```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

Este comando creará un Deployment y un Service en tu clúster de Kubernetes.

## 5. Verificar el Despliegue

### Verificar los Pods

Para asegurarte de que los pods estén corriendo:

```bash
kubectl get pods
```

### Verificar el Servicio

Para obtener la URL del servicio:

```bash
kubectl get services
```

Para obtener la URL directamente desde Minikube:

```bash
minikube service app-service
```

Este comando abrirá la URL del servicio en tu navegador, si estás utilizando Minikube, o mostrará la URL que puedes usar para acceder a tu aplicación.

## 6. Solución de Problemas

Si encuentras problemas, aquí tienes algunos comandos útiles para la solución de problemas:

- **Verificar los logs de un Pod**:

  ```bash
  kubectl logs <pod-name>
  ```

- **Obtener detalles del Deployment**:

  ```bash
  kubectl describe deployment app-deployment
  ```

- **Obtener detalles del Servicio**:

  ```bash
  kubectl describe service app-service
  ```

- **Verificar eventos del clúster**:

  ```bash
  kubectl get events
  ```

