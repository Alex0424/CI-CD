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

Running sequentially is fine but if are too many processes then we have to split them up in parallel(parallelized  processes).

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
```

Note

- everything inside `- -` will be executed parallel.
- for example `sleep-a` and `sleep-b` will be running at the same(parallel) time.
