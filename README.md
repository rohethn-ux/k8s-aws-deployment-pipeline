# K8s AWS Deployment Pipeline

A hands-on project practicing container orchestration with Kubernetes, built on top of an existing Spring Boot telemetry API.

## What's actually working

- Built a Docker image (telemetry-api:v1) from the cloud-native-telemetry-api Spring Boot project.
- Deployed it to a local Kubernetes cluster (Minikube) using a Deployment + NodePort Service.
- Verified the pod runs and the API responds correctly through the Kubernetes service.
- The cluster crashed once due to low system memory and Kubernetes automatically restarted the pod on its own.

## What's next (not built yet)

- Terraform folder exists but is currently empty. Plan is to provision real AWS infrastructure for this workload.
- Currently uses imagePullPolicy Never since the image only lives in Minikube's local Docker.

## What I learned

Docker's buildx builder doesn't work with Minikube's containerd runtime out of the box, so used minikube image build instead. Also saw firsthand that Kubernetes pods restart automatically after a crash.
