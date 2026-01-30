# ----------------------------------------
# PowerShell script to deploy Ollama on Kubernetes
# ----------------------------------------

# 1️⃣ Create namespace for Ollama
kubectl create namespace ollama

# 2️⃣ Define the deployment + service manifest
$manifest = @"
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
"@

# Save manifest to a temporary YAML file
$tempFile = [System.IO.Path]::GetTempFileName() + ".yaml"
$manifest | Out-File -FilePath $tempFile -Encoding utf8

# Apply the manifest
kubectl apply -f $tempFile

# Remove the temporary file
Remove-Item $tempFile

# 3️⃣ Wait for Ollama pod to be ready
kubectl wait --for=condition=ready pod -l app=ollama -n ollama --timeout=300s

# 4️⃣ Get the pod name
$ollamaPod = kubectl get pod -n ollama -l app=ollama -o jsonpath='{.items[0].metadata.name}'

# 5️⃣ Pull a model inside the Ollama pod
kubectl exec -n ollama $ollamaPod -- ollama pull llama3.2:1b
# Note: llama3.2:1b is smaller for Kind clusters
