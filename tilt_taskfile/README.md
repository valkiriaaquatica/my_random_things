# Requirements
(All commands are for Ubuntu on WSL)

### **Install Taskfile**
```bash
sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d
sudo mv ./bin/task /usr/local/bin
```

### **Install Kind**
#### For AMD64 / x86_64:
```bash
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.26.0/kind-linux-amd64
```

Make it executable and move it to your PATH:
```bash
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```

### **Install Tilt**
```bash
curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | bash
```

### **Install Helm**
[Make sure Helm is installed.](https://helm.sh/docs/intro/install/)

### **Install Kubectl**
[Follow the official Kubernetes documentation to install `kubectl`.](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

### **Install Dive (optional) but is really nice**
If you want to inspect Docker image layers:
```bash
curl -OL https://github.com/wagoodman/dive/releases/latest/download/dive_amd64.deb
sudo apt install ./dive_amd64.deb
```

---


## Using Tilt
Tilt is used to setup in a nice UI the services deployed and easy see interactions in them. 
In the Tiltfile are the instrcutions that Tilt will follow to get the cluster and monitor the resources
---


# Workflow
Just run step by step as below or all combine:

### **0. All combine**
```bash
task 
```

### **1. Start the Cluster**
```bash
task create_cluster
```

### **2. Start Tilt**
```bash
task deploy_tilt
```

### **3. Run Tests**
```bash
task run_tests
```

### **4. Inspect the Image (optional)**
```bash
dive <image-name>
```

### **5. Delete the Cluster**
```bash
task delete_cluster
```

---
