# notes for upgrading the kubernetes version in Mojaloop


```bash
#install k3s on instance (we might try k8s later if we run into problems...)
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s -


# Check for Ready node, takes maybe 30 seconds
k3s kubectl get node

# helm setup 
# curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm version

# install default mojaloop helm chart (this will fail)
helm repo add mojaloop http://mojaloop.io/helm/repo/

# TODO: Need to make the namespace first!
helm --namespace kube-public install stable/nginx-ingress

# check out steven's branch with the helm3 changes
git remote add oderayi git@github.com:oderayi/helm.git
git fetch oderayi
git checkout feature/#1070-upgrade-to-helm-3

git checkout -b fix/219-kubernetes-17



# Figure out how to deploy helm locally
kubectl create namespace mojaloop

# in separate window?
cd helm/repo
python3 -m http.server


# helm repo add mojaloop2 http://localhost:8000/index.yaml
# helm install mojaloop-release mojaloop2

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
helm install test3 http://localhost:8000/mojaloop-9.3.0.tgz

helm install test3 http://localhost:8000/account-lookup-service-9.3.0.tgz
helm install test3 http://localhost:8000/account-lookup-service-9.3.0.tgz


```


Making progress, we're now getting this error:
```
1st pass
Error: unable to build kubernetes objects from release manifest: [unable to recognize "": no matches for kind "Deployment" in version "apps/v1beta2", unable to recognize "": no matches for kind "Deployment" in version "extensions/v1beta1", unable to recognize "": no matches for kind "Deployment" in version "apps/v1beta1", unable to recognize "": no matches for kind "StatefulSet" in version "apps/v1beta2", unable to recognize "": no matches for kind "StatefulSet" in version "apps/v1beta1"]


2nd pass
Error: unable to build kubernetes objects from release manifest: [unable to recognize "": no matches for kind "Deployment" in version "extensions/v1beta1", unable to recognize "": no matches for kind "Deployment" in version "apps/v1beta1", unable to recognize "": no matches for kind "StatefulSet" in version "apps/v1beta2", unable to recognize "": no matches for kind "StatefulSet" in version "apps/v1beta1"]


3rd pass
Error: unable to build kubernetes objects from release manifest: [unable to recognize "": no matches for kind "Deployment" in version "extensions/v1beta1", unable to recognize "": no matches for kind "Deployment" in version "extensions/v1", unable to recognize "": no matches for kind "StatefulSet" in version "apps/v1beta2", unable to recognize "": no matches for kind "StatefulSet" in version "apps/v1beta1"]


4th pass
Error: unable to build kubernetes objects from release manifest: [unable to recognize "": no matches for kind "Deployment" in version "extensions/v1beta1", unable to recognize "": no matches for kind "StatefulSet" in version "apps/v1beta2", unable to recognize "": no matches for kind "StatefulSet" in version "apps/v1beta1"]


5th pass
Error: unable to build kubernetes objects from release manifest: [unable to recognize "": no matches for kind "Deployment" in version "extensions/v1beta1", unable to recognize "": no matches for kind "StatefulSet" in version "apps/v1beta2", unable to recognize "": no matches for kind "StatefulSet" in version "apps/v1beta1"]
```

