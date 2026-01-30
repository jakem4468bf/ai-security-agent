# Applied Network Security - AI Security Agent

## Overview 
This repository contains work for both project 1 (Building an Agent with Kagent and Ollama) and project 2 (Securing Agent Communications with Agentgateway)
### Project 1: 
* Deploy a Kubernetes troubleshooting agent using Kagent with Ollama (llama3.2:1b) as the local LLM in a Kind cluster.
### Project 2
* Deploy Agentgateway to secure and observe communications between AI agents and MCP servers with policy-based access control.
## Setup Instructions
I recommend setting this project up in a linux envoirnment as there is several things here that don't work directly with windows. However it is still possible to do this within windows, I have added notes to instructions for windows.

`git clone https://github.com/jakem4468bf/ai-security-agent.git`

Install docker engine (docker desktop on windows), Kubectl and kind.


### Project 1: Building an Agent with Kagent and Ollama

#### Step 1: Basic Start up: Create a Kind Cluster
Create a Kind cluster with port mappings for HTTP and HTTPS traffic. Verify the cluster is running.

#### Step 2: Basic Start up: Install Ollama in the Cluster
Create the `ollama` namespace and deploy Ollama. Wait for the pod to be ready, then pull the `llama3.2:1b` model.

#### Step 3: Install Kagent
Install the Kagent CLI and deploy Kagent to the cluster in the `kagent` namespace. Wait for the controller to be ready.

Note: Kagent CLI will not download directly without chocolatey on windows. Install it from Chocolatey.org. 

#### Step 4: Create ModelConfig for Ollama
Apply the `modelconfig.yaml` to configure Kagent to use Ollama as the LLM provider.

#### Step 5: Create Your First Agent
Apply the `agent.yaml` to create the Kubernetes troubleshooting agent with MCP tools.

#### Step 6: Access the Agent
Test and interact with agent via CLI (kagent agent chat k8s-troubleshooter -n kagent) or Browser at http://localhost:8080

### Project 2: Securing Agent Communications with Agentgateway

#### Step 1: Install Kgateway with Agentgateway Data Plane
Install Kgateway using Helm with the Agentgateway data plane. Wait for all components to be ready.

Note: Same as kagent this will need chocolately for windwows. Chocolately.org

#### Step 2: Deploy a Sample MCP Server
Create the `mcp` namespace and deploy a sample MCP server (time server) `mcp.sh`

#### Step 3: Deploy Agentgateway Gateway
Apply the `gateway.yaml` to create the Gateway resource.

#### Step 4: Configure Backend and Route
Apply the `backend.yaml` to configure the MCP server backend. Apply the `httproute.yaml` to route traffic from the gateway to the backend.

#### Step 5: Configure Authorization Policy
Apply the `trafficpolicy.yaml` to restrict tool access using RBAC policies.

#### Step 6: Register Agentgateway with Kagent
Register RemoteMCPServer resource with `RegAgentGateway.sh` to expose the gateway to Kagent agents.

#### Step 7: Update Agent to Use Agentgateway
Apply the `updated-agent.yaml` to configure the agent to use tools through the gateway.

## Software versions:

Kubectl: 
* Client Version: v1.34.0
* Kustomize Version: v5.7.1
* Server Version: v1.34.0

Docker:

* Docker version 29.0.1, build eedd969

Kubernetes:
* v0.7.5

Kagent:
* v0.7.5

## Project Structure

AI security agent/

├── project1/

│   ├── yaml/

│   │   ├── modelconfig.yaml

│   │   └── agent.yaml

├── project2/

│   ├── yaml/

│   │   ├── gateway.yaml

│   │   ├── backend.yaml

│   │   ├── httproute.yaml

│   │   ├── trafficpolicy.yaml

│   │   └── updated-agent.yaml

└── README.md
