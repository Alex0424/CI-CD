# Info

## Argo workflow values

- Designed to be cloud native.
  - Full potential for Kubernetes.
- Perform machine learning operations
  - set of task in a workflow (CI-CD pipelines).
- Open source.
  - Dedicated contributors.

## [Demo](https://youtu.be/UMaivwrAyTA)

### Prerequisite

- Running Kubernetes cluster.

- Argo workflow installed.

- A secret to authenticate to docker hub (push images).

### Terminal Actions

```shell
git clone https://github.com/repo-with-workflow
```

```shell
cat workflows/silly.yaml
```
```yml
apiVersion: argoproj:io/v1alpha1
kind: Workflow
metadata:
  generateName: very-
  labels:
    workflows.argoproj.io/archive-strategy: "false"
spec:
  entrypoint: silly
  serviceAccountName: workflow
  templates:
  - name: silly
    container:
      image: alpine:latest
      command: [ls]
      args: ["-l"]
```

Running sequentially is fine but if there is too many processes then we have to split each process in parallel(parallelized  processes).

See yaml example below:

```yaml
apiVersion: something:io/Something
kind: Workflow
metadata:
  generateName: parallel-
  labels:
    workflow.argoproj.io/archive-strategy: "false"
spec:
  entrypoint: hello
  serviceAccountName: workflow
  templates:
  - name: hello
    steps:
    - - name: ls
      - template: template-ls
    - - name: sleep-a
        template: template-sleep
      - name: sleep-b
        template: template-sleep
    - - name: delay
        template: template-delay
    - - name: sleep
        template: template-sleep
  - name: template-ls
    container:
      image: alpine
      command: [ls]
      args: ["-l"]
  - name: template-sleep
    script:
      image: alpine
      command: [sleep]
      args: ["10"]
  - name: template-delay
    suspend:
      duration: "600s"
```

Note

- everything inside `- -` will be executed parallel.
- for example `sleep-a` and `sleep-b` will be running at the same(parallel) time.

### DAG - Directed Acyclic Graph

There is another way to specify how things should run and what comes after what, and that is called DAG (Directed Acyclic Graph)

In yaml files all the task that you specify will be executed at the same time (parallel) unless you add a key-value `dependencies: \n- task-a`

Example:
```yaml
- name: task-b
  template: my-task
  arguments:
    parameters:
    - name: message
      value: This is task-b
- name: task-c
  template: my-task
  arguments:
    parameters:
    - name: message
      value: This is task-c
- name: task-d
  template: my-task
  arguments:
    parameters:
    - name: message
      value: This is task-d
  dependencies:
  - task-b
  - task-c
```

Task B and C will be executed parallely while task D will wait for B and C to be completed.

### Commonly Used Template


```yaml
tasks:
- name: build-container-image
  templateRef:
    name: container-image
    template: build-kaniko-git # <-- points to another YAML file that defines the build-kaniko-git template
    clusterScope: true
  arguments:
    parameters:
    - name: app_repo
      value: git@github.com/vfarcic/devops-toolkit
    - name: container_image
      value: vfarcic/devops-toolkit
    - name: container_tag
      value: "1.0.0"
- name: deploy-staging
  template: echo
  arguments:
    parameters:
    - name: message
      value: Deploying to the staging environment
  dependencies:
    - build-container-image
- name: tests
  template: echo
  arguments:
  ...
```

The other file
```yml
apiVersion: argoproj.io/v1alpha1
kind: ClusterWorkflowTemplate
metadata:
  name: container-image
spec:
  templates:
    - name: build-kaniko-git
      inputs:
        parameters:
          - name: app_repo
          - name: container_image
          - name: container_tag
      container:
        image: gcr.io/kaniko-project/executor:debug
        args:
          - --context={{inputs.parameters.app_repo}}
          - --destination={{inputs.parameters.container_image}}:{{inputs.parameters.container_tag}}
        volumeMounts:
          - name: kaniko-secret
            mountPath: /kaniko/.docker/
```

### Kubectl

Export workflow

```shell
kubectl --namespace workflows apply --filename workflow-templates/container-image.yaml
```

Run workflow

```shell
argo --namespace workflows submit workflows/cd-mock.yaml
```

List Workflow

```shell
argo --namespace workflows list
```

Workflow Status

```
argo --namespace workflows get @latest
```

Logs

```
argo --namespace workflows logs @latest --follow
```

Get pods

```
kubectl --namespace workflows get pods
```

### Open Argo Workflows GUI Webpage:

```
open http://$ARGO_WORKFLOWS_HOST
```

On the page select -> `worklows` -> `namespace: workflows` 

### Good to Know

ArgoCD put each task in a separate pod.
- Potential problems: sharing state and volumes.
- Powerfull: distribute the workload across the cluster.
- Cron-job: calendar executed tasks

Problem:
- Isolation

Solution:
- Argo Events!!!
  - Argo Events can listen to even sources and then trigger Argo Workflows (trigger).
    - Combine with Argo CD
    - Add Argo Rollouts to get progressive delivery.
- / Changes in git / on image push / on deploy / (bad option, its silly)
