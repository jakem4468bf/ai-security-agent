cat <<EOF | kubectl apply -f -
apiVersion: kagent.dev/v1alpha1
kind: MCPServer
metadata:
name: sample-mcp-server
namespace: mcp
labels:
kagent.dev/discovery: disabled
spec:
deployment:
image: ghcr.io/modelcontextprotocol/servers/time:latest
port: 3000
transportType: stdio
EOF

# Verify MCP server is deployed
kubectl get mcpserver -n mcp
kubectl get pods -n mcp
```