# Argo CD

## [Introduction](https://youtu.be/2WSJF7d8dUg)

### Install Argo

```shell
kubectl create namespace argocd
```

Option 1: Command

```shell
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
```shell
kubectl -n argocd apply -f ./install.yaml
```

Option 2: Save as file

It's better becouse then manifest won't change if there is new update and also you would be able to see if there is any suspecios info in the yaml content.

```shell
curl -o install.yaml https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Check pods

```shell
kubectl -n argocd get pods
```

Output

Controller plane = Looks after all `kind: Application` values and will automatically sync with Argo API/CLI server.

API server = 

```shell
NAME                                               READY   STATUS             RESTARTS   AGE
argocd-application-controller-9f66f9c54-dtf2w      1/1     Running            0          19s  <-- controller plane
argocd-dex-server-559f749f75-nxlfl                 0/1     PodInitializing    0          19s
argocd-redis-868b8cb57f-nb49k                      1/1     Running            0          19s
argocd-repo-server-74f7d76f8b-w194q                0/1     ContainerCreating  0          18s
argocd-server-7c95d549d4-vgwrt                     0/1     Running            0          18s  <-- API server
```

[Port Forwarding](https://argo-cd.readthedocs.io/en/stable/getting_started/#port-forwarding)

```shell
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

The API server can then be accessed using https://localhost:8080

```shell
kubectl apply -n argocd -f ./app.yaml
```
In argocd server GUI
- go to application tab, here you should see your newly created app.
- Check Logs for errors, image pull loop, bugs.

## [More Argo CD | Nana](https://youtu.be/MeU5_k9ssrs)

### CD workflow without Argo CD )=

CI/CD Server Example:

[test] -> [build image] -> [push to docker repo] -> [update K8s manifest file] -> [kubectl apply]

```mermaid
graph LR
    A[Test] --> B[Build Image]
    B --> C[Push to Docker Repo]
    C --> D[Update K8s manifest File]
    D --> E[kubectl apply...]
    E --> F[New version deployed!]
    subgraph CI
        A --> B
    end
    subgraph CD
        D --> E
    end
    subgraph "CI / CD Server"
        C
    end
```

Challenges with this approach (configure on jenkins)
- Install and setup tools, like kubectl/helm
- configure access to K8s
- Configure access to cloud platforms
- Security challange (Cluster credentials external services and tools)
- Alot of projects will deploy applications to the cluster. Each project need its own kubernetes credential so it can only access the specific application resources in the cluster.
- Configure credentials for each and every cluster.
- No visibility in deployment status. Example: Jenkins does not know the status of execution, was app created, healthy status, failing to start?

### CD part can be improved - with Argo CD (=

Argo CD was built for:
- continous delivery for Kubernetes Cluster (more efficient)
- Based on GitOps
- No External access (e.g. Jenkins is external)
- Internal access (Argo CD is part of K8s cluster)

How it Argo CD works:
- ArgoCD agent pulls K8s manifest changes and applies them (compare to traditional: on push)

CD Workflow with ArgoCD
1. Deploy ArgoCD in K8s cluster.
2. Configure ArgoCD to track Git repository.
3. ArgoCD monitors for any changes and applies automatically.


User Commit -> Git repository -> trigger CI pipeline
```mermaid
graph TD
    A[User Commit] --> B[Git repository]
    B --> C[trigger CI pipeline]
```

Test -> Build Image -> Push to Docker Repo -> Update K8s manifest File

```mermaid
graph LR
    A[Test] --> B[Build Image]
    B --> C[Push to Docker Repo]
    C --> D[Update K8s manifest File]
```


ArgoCD is not synced -> ArgoCD pull manifest -> ArgoCD monitor -> loop again
```mermaid
graph TD
    A[ArgoCD is not synced] --> B[ArgoCD pull manifest]
    B --> C[ArgoCD monitor]
    C --> A
```

When updating manifest file usually the Deployment yaml file will change the version at `image: app:2.0` part.

> Note (Best Practice for Git Repository):
-  Separate git repositories for application source code and application configuration (K8s manifest files).
- Even separate git repository for system configurations (First repo for source code and second repo for app configuration).

Why separate Git Repository?
- Not only Deployment.yaml, but also ConfigMap, Secret, Service, Ingress.

- K8s manifest files can change independent of source code.
- You don't want to trigger the full CI pipeline, when app source code has not changed while app config has.
- You don't want complex logic in CI pipeline that checks what have changed in K8s manifest.
