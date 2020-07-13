## Download AWS CLI V2

Download the AWS CLI MSI installer for Windows (64-bit) at https://awscli.amazonaws.com/AWSCLIV2.msi.
By default, the AWS CLI installs to C:\Program Files\Amazon\AWSCLIV2.
To confirm the installation, open the Start menu >> CMD >> aws --version

To connect with AWS account,

$ aws configure
AWS Access Key ID [****************G7JA]: ######################
AWS Secret Access Key [****************3y5L]: ######################
Default region name [ap-south-1]: #######
Default output format [None]:

## Download kubectl

1)Open Powershell
curl -o kubectl.exe https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/windows/amd64/kubectl.exe
2) Verify the downloaded binary
curl -o kubectl.exe.sha256 https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/windows/amd64/kubectl.exe.sha256
3)Check the SHA-256 sum for your downloaded binary.
Get-FileHash kubectl.exe
4)Copy the binary to a folder in your PATH
5)After you install kubectl, you can verify its version with the following command:
kubectl version --short --client


## Terraform apply

terraform init
terraform plan
terraform apply
Confirm yes to Create the cluster.


Run $ kubectl get svc 
if Cluster is not connected then configure kubectl

## Configure kubectl

terraform output kubeconfig # save output in ~/.kube/config
aws eks --region <region> update-kubeconfig --name eks-poc

kubectl get nodes  

if you get no resources found in namespace then configure the configmap for AWS auth.


## Configure config-map-auth-aws

terraform output config-map-aws-auth # save output in config-map-aws-auth.yaml
kubectl apply -f config-map-aws-auth.yaml


## See nodes coming up

kubectl get nodes


## Helm package installer.
Download Helm binaries and open CMD or powershell from the helm installation path.

helm init --service-account tiller --upgrade

## Add tiller to the namespace.

kubectl create serviceaccount tiller -n kube-system
kubectl create clusterrolebinding tiller-is-admin --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller --upgrade

## Add helm repo and install the helm charts.

helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm install stable/jenkins --name jenkins

## Check POD Status
kubectl get pods
NAME                      READY   STATUS    RESTARTS   AGE
jenkins-d7797669b-6g4wv   2/2     Running   0          15m

## Destroy
Make sure all the resources created by Kubernetes are removed:

terraform destroy

