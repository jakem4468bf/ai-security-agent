# ----------------------------------------
# PowerShell script to create a Kind cluster
# with ingress-ready node
# ----------------------------------------

# Define the cluster configuration as a multi-line string
$kindConfig = @"
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    kubeadmConfigPatches:
      - |
        kind: InitConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "ingress-ready=true"
    extraPortMappings:
      - containerPort: 80
        hostPort: 80
        protocol: TCP
      - containerPort: 443
        hostPort: 443
        protocol: TCP
"@

# Run kind using the configuration
# This pipes the config string to kind
$kindConfig | kind create cluster --config=-
