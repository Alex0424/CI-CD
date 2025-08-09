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

more coming soon...