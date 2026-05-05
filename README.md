# My CIS-92 Project 

This repository has the starter code for CIS-92. 

Author: Logan Rogge-Amos

# MySite Kubernetes Deployment

This project deploys a Django-based web application to a Kubernetes cluster using a Pod, ConfigMap, Secret, PersistentVolumeClaim, and Service.

---

## Environment Variables

The following environment variables are defined via `config.yaml`, `secret.yaml`, and the Dockerfile:

| Variable Name | Default Value (Dockerfile) | Description |
|--------------|--------------------------|------------|
| PORT | 8080 | Port the application runs on |
| STUDENT_NAME | Logan | Name of the student running the app |
| SITE_NAME | www.cis-92.com | Website domain name |
| DATA_DIR | /data | Directory for persistent data storage |
| DEBUG | 1 | Enables debug mode (1 = on, 0 = off) |
| SECRET_KEY | fixme-12345 | Django secret key (should be overridden by secret) |
| DJANGO_SUPERUSER_NAME | test | Django admin username |
| DJANGO_SUPERUSER_EMAIL | test@test.test | Django admin email |
| DJANGO_SUPERUSER_PASSWORD | test | Django admin password |

> Note: Values from `config.yaml` override Dockerfile defaults where applicable.

---

## Kubernetes Components

- **ConfigMap (`mysite-config`)** – Stores non-sensitive environment variables  
- **Secret (`mysite-secret`)** – Stores sensitive values like `SECRET_KEY`  
- **Pod (`mysite`)** – Runs the Django container  
- **PersistentVolumeClaim (`mysite-data`)** – Provides 1Gi storage mounted at `/data`  
- **Service (`mysite`)** – Exposes the app externally via LoadBalancer  

---

## Deploying the Application

1. Apply the ConfigMap:
   ```bash
   kubectl apply -f config.yaml
   ```

2. Apply the Secret:
   ```bash
   kubectl apply -f secret.yaml
   ```

3. Create the Persistent Volume Claim:
   ```bash
   kubectl apply -f pvc.yaml
   ```

4. Deploy the Pod:
   ```bash
   kubectl apply -f pod.yaml
   ```

5. Expose the application with the Service:
   ```bash
   kubectl apply -f service.yaml
   ```

6. Get the external IP:
   ```bash
   kubectl get svc mysite
   ```

7. Open the app in your browser using the external IP.

---

## Deleting the Application

1. Delete the Service:
   ```bash
   kubectl delete -f service.yaml
   ```

2. Delete the Pod:
   ```bash
   kubectl delete -f pod.yaml
   ```

3. Delete the Persistent Volume Claim:
   ```bash
   kubectl delete -f pvc.yaml
   ```

4. Delete the ConfigMap:
   ```bash
   kubectl delete -f config.yaml
   ```

5. Delete the Secret:
   ```bash
   kubectl delete -f secret.yaml
   ```

---

## Notes

- The app runs on port **8080** internally and is exposed on port **80**
- Persistent data is stored in `/data`
- Debug mode is enabled (`DEBUG=1`) and should be disabled in production