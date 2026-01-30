# Applied Network Security 2025 - Final Assignment AI Security Agents
## Jake Martins StudentID: 991734093. Submission Date: 12/09/25

## Overview 
This repository contains work for both project 1 (Building an Agent with Kagent and Ollama) and project 2 (Securing Agent Communications with Agentgateway)
### Project 1: 
* Deployed a Kubernetes troubleshooting agent using Kagent with Ollama (llama3.2:1b) as the local LLM in a Kind cluster.
### Project 2
* Deployed Agentgateway to secure and observe communications between AI agents and MCP servers with policy-based access control.

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