# K8s AWS Deployment Pipeline

A hands-on project practicing container orchestration and infrastructure-as-code, built on top of an existing Spring Boot telemetry API.

## What's actually working

- Built a Docker image (telemetry-api:v1) from the cloud-native-telemetry-api Spring Boot project.
- Deployed it to a local Kubernetes cluster (Minikube) using a Deployment + NodePort Service.
- Verified the pod runs and the API responds correctly through the Kubernetes service.
- The cluster crashed once due to low system memory and Kubernetes automatically restarted the pod on its own.
- Wrote Terraform configuration to provision AWS infrastructure: a security group and a t2.micro EC2 instance (free-tier eligible), with Docker installed automatically via user_data. Validated successfully with terraform init and terraform validate.

## What's next (not fully run yet)

- Terraform code is written and validated but not yet applied against a live AWS account - my account is currently stuck in pending verification (AWS Support case open). Once resolved, terraform apply will provision the EC2 instance for real.
- Currently uses imagePullPolicy Never for Kubernetes since the image only lives in Minikube's local Docker.

## What I learned

Docker buildx doesn't work with Minikube's containerd runtime, so used minikube image build instead. Learned that Terraform provider binaries should never be committed to git - they can be hundreds of MB and get rejected by GitHub's file size limit, so .gitignore should exclude that folder from the start. Also saw firsthand that Kubernetes pods restart automatically after a crash.
