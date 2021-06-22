# Deploy a production-ready Kubernetes cluster to Google cloud

## Application
A web application for calculating Fibonacci sequence consists of the following part:
- frontend: React 
- backend: Express
- routing: Ingress
- cache: Redis
- database: Postgres

## CI/CD pipeline with Kubernetes
Set up a CI/CD Process on GitHub with Travis CI with `.travis.yml` and `deploy.sh`.
The Kubernetes config files are saved in `k8s` folder. 
- Each component of the web application is dockerized in a Pod and a Deployment can set the number of pods.
- The Services' ClusterIPs are properly set to enable the communication among different Pods in a Node.
- Kubernetes Ingress controller serves a load balancer that routes traffic to frontend and backend.

Once the codes are pushed to Github, Travis CI will build, test, and deploy the application's codebase to Google cloud.
