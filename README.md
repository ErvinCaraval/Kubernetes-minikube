# Guía de Comandos para Kubernetes con MicroK8s

Este archivo `README.md` proporciona una explicación detallada de los comandos utilizados para gestionar un clúster de Kubernetes con MicroK8s. Estos comandos cubren la verificación de nodos, la aplicación de taints y etiquetas, la creación y eliminación de pods, y la aplicación de manifiestos.

## 1. Acceso al Nodo Control-Plane

```bash
vagrant ssh control-plane
```

- **Propósito**: Conectar al nodo `control-plane` utilizando SSH a través de Vagrant. Esto te permite ejecutar comandos dentro del entorno del nodo control-plane.

## 2. Verificar el Estado del Clúster

```bash
microk8s kubectl get nodes
```

- **Propósito**: Listar todos los nodos en el clúster de Kubernetes. Muestra información básica sobre cada nodo, como el nombre, el estado, y el rol.

## 3. Verificar el Estado de MicroK8s

```bash
microk8s status
```

- **Propósito**: Mostrar el estado general de MicroK8s. Incluye información sobre los servicios y addons que están habilitados.

## 4. Describir el Nodo Control-Plane

```bash
microk8s kubectl describe node control-plane
```

- **Propósito**: Proporcionar detalles extensos sobre el nodo `control-plane`, incluyendo etiquetas, taints y condiciones. Esto es útil para verificar la configuración y el estado del nodo.

## 5. Aplicar un Taint al Nodo Control-Plane

```bash
microk8s kubectl taint nodes control-plane node-role.kubernetes.io/control-plane:NoSchedule
```

- **Propósito**: Aplicar un taint al nodo `control-plane` para evitar que los pods se programen en él, a menos que tengan una toleración correspondiente. Esto es útil para reservar el nodo para tareas específicas.

## 6. Etiquetar el Nodo `node-1` con "testing"

```bash
microk8s kubectl label nodes node-1 environment=testing
```

- **Propósito**: Aplicar una etiqueta al nodo `node-1` para clasificarlo como "testing". Las etiquetas se utilizan para seleccionar y programar pods en nodos específicos.

## 7. Mostrar Etiquetas de los Nodos

```bash
microk8s kubectl get nodes --show-labels
```

- **Propósito**: Listar todos los nodos y mostrar sus etiquetas. Esto ayuda a verificar que las etiquetas se han aplicado correctamente.

## 8. Etiquetar el Nodo `node-2` con "production"

```bash
microk8s kubectl label nodes node-2 environment=production
```

- **Propósito**: Aplicar una etiqueta al nodo `node-2` para clasificarlo como "production". Similar a la etiqueta anterior, pero en un nodo diferente.

## 9. Describir el Nodo `node-1` y `node-2`

```bash
microk8s kubectl describe node node-1
microk8s kubectl describe node node-2
```

- **Propósito**: Proporcionar detalles extensos sobre los nodos `node-1` y `node-2`. Esto incluye etiquetas, taints, y el estado del nodo.

## 10. Crear un Pod con Imagen de Nginx

```bash
microk8s kubectl run test-pod1 --image nginx
```

- **Propósito**: Crear un pod llamado `test-pod1` que utiliza la imagen de Nginx. Este comando se utiliza para probar la programación de pods y su ubicación en los nodos.

## 11. Listar Pods y Ver Ubicación

```bash
microk8s kubectl get pods -o wide
```

- **Propósito**: Listar todos los pods y mostrar información adicional, como el nodo en el que se están ejecutando. Esto ayuda a verificar la ubicación de los pods.

## 12. Eliminar Pods

```bash
microk8s kubectl delete pod test-pod1 test-pod10 test-pod2 test-pod5
```

- **Propósito**: Eliminar los pods especificados. Esto puede ser útil para limpiar recursos y probar la reprogramación de pods.

## 13. Verificar Pods Después de Eliminación

```bash
microk8s kubectl get pods -o wide
```

- **Propósito**: Verificar la lista de pods después de haber eliminado algunos. Asegúrate de que los pods se han eliminado correctamente y revisa la ubicación de los pods restantes.

## 14. Editar el Archivo `production-pod.yaml`

```bash
nano production-pod.yaml
```

- **Propósito**: Editar el archivo `production-pod.yaml` usando el editor de texto `nano`. Este archivo contiene la definición del pod con toleraciones y afinidad de nodo.

## 15. Aplicar el Manifiesto del Pod

```bash
kubectl create -f production-pod.yaml
```

- **Propósito**: Crear un pod utilizando el manifiesto definido en `production-pod.yaml`. Este comando aplicará las configuraciones especificadas en el archivo, como toleraciones y afinidad de nodo.

---

Este `README.md` proporciona una visión general de los comandos utilizados para gestionar un clúster de Kubernetes con MicroK8s, explicar su propósito y cómo se utilizan en diferentes etapas del proceso de administración de pods y nodos.