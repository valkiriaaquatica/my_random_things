#  MIRRRORD Quickstart in Local development

## REQUIREMENTS
- Docker
- Kind https://kind.sigs.k8s.io/docs/user/quick-start/
- brew install mirrord

## Test **MIRRORD** development  With `kind`

```bash
kind create cluster --name mirrord
docker build -t http-python:0.0.1 .
kind load docker-image http-python:0.0.1 --name mirrord
kubectl apply -k ../manifests-app/manifests-kind/
mirrord exec -n mirrord-demo --target deployment/http-python -- python main.py
```

Edit `main.py`, press `Ctrl+C`, and rerun the `mirrord` command to test changes.

---

## With K8s + Ingress (my example is k3s)

```bash
helm install ingress-nginx ingress-nginx/ingress-nginx \
  -n ingress-nginx -f ingress-nginx/values.yaml --create-namespace

kubectl apply -k manifests-app/manifests-k8/
```

 Map `http-python.local` to your cluster IP (e.g., via `/etc/hosts`).

```bash
mirrord exec -n mirrord-demo --target deployment/http-python -- python main.py
```
Continue making some chaning and pressing Ctrl+C` you can have the access to your code changed

 Access:  
- Local (via mirrord): `http://localhost:8080`  
- Cluster (Ingress): `http://http-python.local`
