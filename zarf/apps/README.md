# Zarf Deployment Guide

#### Requirments 
- Have a kubernetes cluster deployed, no problem if it is k3d, minikube, k3s, eks, aks, rke2....
   In my case k3s, installing with:  curl -sfL https://get.k3s.io | sh -
- Have zarf installed in your cli, in my case: https://docs.zarf.dev/getting-started/install/


## Prepare Zarf in the Air-gapped cluster
Make sure you have direct communication with the cluster from your machine who has internet
   ```bash
   zarf init --confirm
   ```
This will create the necessary resoruces for zarf to manage the following apps. Make sure the remote cluster
has the needed opened ports (probably is 5000). If you receive some network errorr, rerun the above bash command
sometimes it fails.
The main things this will deploy are these: 



## **Deploy a Package**
Create the zarf.yaml with the application(s) you want, prepare them before all the steps above. Check the video for a detailed
explanation on this :))

1. **Create the Package**:
   ```bash
   zarf package create --confirm
   ```
   This wil ccreate a <package-name.tar.zst> that will contain all the encessary thins to deploy.
2. **Deploy the Package**:
   ```bash
   zarf package deploy  <package-name.tar.zst> 
   ```

## **Update a Package**

1. Rereate the updated package with the new values for the applicaiotn (new verison of images in the zarf.yaml)
   ```bash
   zarf package create --confirm
   ```
2. Deploy the new package:
   ```bash
   zarf package deploy  <package-name.tar.zst>  --confirm
   ```

## **Utilities**

- **Inspect a Package**:
    This will show the ZarfPackageConfig  resource explainign what is gonna be deplyed. Importar,t check the images are the right ones.
  ```bash
  zarf package inspect <package-name>.zst   
  ```
- **List Images in Registry**:
    Check the images needd for the peloyment are in the repository (this is the iternet machine repository)
  ```bash
  zarf tools registry catalog
  ```

## **Notes**

- Check image values manually in `Chart.yaml` for version updates.
- "Zero Resources" ensure offline deployments by bundling images and agents.

```