```bash
# Create namespace for Ollama
kubectl create namespace ollama

# Deploy Ollama using Helm (if you have Helm) or create a simple deployment
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
name: ollama
namespace: ollama
spec:
replicas: 1
selector:
matchLabels:
app: ollama
template:
metadata:
labels:
app: ollama
spec:
containers:
- name: ollama
image: ollama/ollama:latest
ports:
- containerPort: 11434
resources:
requests:
memory: "4Gi"
cpu: "2"
limits:
memory: "8Gi"
cpu: "4"
volumeMounts:
- name: ollama-data
mountPath: /root/.ollama
volumes:
- name: ollama-data
emptyDir: {}
---
apiVersion: v1
kind: Service
metadata:
name: ollama
namespace: ollama
spec:
selector:
app: ollama
ports:
- port: 11434
targetPort: 11434
type: ClusterIP
EOF

# Wait for Ollama to be ready
kubectl wait --for=condition=ready pod -l app=ollama -n ollama --timeout=300s

# Pull a model (using exec into the pod)
OLLAMA_POD=$(kubectl get pod -n ollama -l app=ollama -o jsonpath='{.items[0].metadata.name}')
kubectl exec -n ollama $OLLAMA_POD -- ollama pull llama3.2:1b
# Note: Use a smaller model like llama3.2:1b for Kind cluster due to resource constraints
```
