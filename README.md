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
7. Or Deploy entire project from file;
   ```bash
   kubectl apply -f deployment/
   ```

8. Open the app in your browser using the external IP.

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
6. Or, Delete all at once:
   ```bash
   kubectl delete -f deployment/
   ```

---

## Notes

- The app runs on port **8080** internally and is exposed on port **80**
- Persistent data is stored in `/data`
- Debug mode is enabled (`DEBUG=1`) and should be disabled in production

## 11. Postgres

The application uses a PostgreSQL database installed with Helm using the Bitnami PostgreSQL chart. The database configuration is stored in `values-postgres.yaml`.

### Postgres Configuration Settings

| Setting | Value | Description |
|--------|-------|-------------|
| `auth.username` | `mysiteuser` | Username used to log in to the Postgres database |
| `auth.password` | `this-is-a-bad-password` | Password used to log in to the Postgres database |
| `auth.database` | `mysite` | Name of the Postgres database |
| `primary.resources.requests.memory` | `512Mi` | Minimum memory requested for the Postgres pod |
| `primary.resources.requests.cpu` | `500m` | Minimum CPU requested for the Postgres pod |
| `primary.resources.requests.ephemeral-storage` | `100Mi` | Minimum temporary storage requested for the Postgres pod |
| `primary.resources.limits.memory` | `512Mi` | Maximum memory allowed for the Postgres pod |
| `primary.resources.limits.cpu` | `500m` | Maximum CPU allowed for the Postgres pod |
| `primary.resources.limits.ephemeral-storage` | `100Mi` | Maximum temporary storage allowed for the Postgres pod |

> Note: This password is for lab/testing purposes only and should not be used in a real production environment.

---

## Updated Deployment Steps

Before deploying the Django application, install the Postgres database with Helm.

1. Install Postgres using Helm and the `values-postgres.yaml` file:

```bash
   helm install postgres oci://registry-1.docker.io/bitnamicharts/postgresql --values values-postgres.yaml
```
   Then check that the Postgres resources were created:

```bash
kubectl get all
```

Check that the Postgres PersistentVolumeClaim was created:

```bash
kubectl get pvc
```

After Postgres is running, deploy the application:

```bash
kubectl apply -f deployment/
```

Check that the application resources are running:

```bash
kubectl get all
```

To delete the application
```bash
Then check that the Postgres resources were created:

```bash
kubectl get all
```

Check that the Postgres PersistentVolumeClaim was created:

```bash
kubectl get pvc
```

After Postgres is running, deploy the application:

```bash
kubectl apply -f deployment/
```

Check that the application resources are running:

```bash
kubectl get all
```

Uninstall the Postgres helm chart

```bash
helm uninstall postgres
```

To fully remove the stored Postgres database data, delete the PersistentVolumeClaim:

```bash
kubectl delete pvc/data-postgres-postgresql-0
```