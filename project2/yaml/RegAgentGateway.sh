```bash
# Create RemoteMCPServer to expose Agentgateway to Kagent
cat <<EOF | kubectl apply -f -
apiVersion: kagent.dev/v1alpha2
kind: RemoteMCPServer
metadata:
name: agw-mcp-gateway
namespace: kagent
spec:
description: "Agentgateway as MCP gateway"
protocol: STREAMABLE_HTTP
sseReadTimeout: 5m0s
terminateOnClose: true
timeout: 30s
url: http://agentgateway.mcp.svc.cluster.local:3000
EOF

# Verify RemoteMCPServer is accepted
kubectl get remotemcpserver -n kagent
kubectl describe remotemcpserver agw-mcp-gateway -n kagent
```