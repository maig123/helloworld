# Description
Easily scalable helloworld app (python flask) with postgresql database. 

helloworld application is available at http://35.237.46.18/

monitoring is available at http://34.138.124.61/

for grafana, login using the default account for the kube-prom-stack
 - user: admin
 - password: prom-operator 

go to the 00 dashboard for helloworld
link: http://34.138.124.61/d/fdirr3fxkuolca/00-dashboard-for-helloworld?orgId=1


# Pre-requisites

Create Google Project
- Enable compute engine
- Enable container engine
- create a bucket for tfstate 

# usage
    terraform init
    terraform plan
    terraform apply 
    kubectl create namespace helloworld
    kubectl create namespace monitoring 
    helm install monitoring prometheus-community/kube-prometheus-stack -n monitoring -f monitoring/monitoring-values.yaml
    helm install database bitnami/postgresql -n helloworld -f database/values.yaml
    kubectl apply -f appdeploy/hellodeploy.yaml
    kubectl apply -f dashboard-json.yaml

# discussion on work
### helm/kubernetes integration into terraform 
To make it run together, we can actually providers for helm and kubernetes in terraform to install the helm charts and applications through terraform. However, it is better to have ArgoCD setup and configured to a git repository and chart repository where it can load the values.yaml and charts from there since it can be awkward to manage those things with terraform. 

### use of GKE modules
Very basic deployment for GKE. K8S is great for applications anticipating large scale growth. The GKE module itself might not be suitable for all deployments depending on cloud and security constraints. 

### use of bitnami database
Just uses the vanilla bitnami database without additional configurations. Loads "helloworld" as an init script. Since the application just needs to read it from the database, this is a quick and easy solution and not something you would normally do. 

### building flask app
Built as a container. Using public registries to pull and push to, which normally we wouldn't do that. Furthermore user and group configurations are not setup. Container is not hardened. 

### deploying flask app 
Kubernetes deployment with Deployment, Service, ServiceMonitor (for prometheus/grafana monitoring). Using loadbalancer service to get external addresses through GCP. Would normally consider making a helm template to deploy if many python/flask applications are being made 

### use of prometheus/grafana monitoring stack
Prometheus/Grafana makes it easy to incorporate metrics, especially middlware metrics (like flask). Additional monitoring
Setting up the prometheus exporter for postgresql to get database metrics as well. however flask HTTP health and status errors should give a good enough indication 