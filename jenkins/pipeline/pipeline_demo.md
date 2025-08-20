## Jenkins Pipeline

[Official Docs](https://www.jenkins.io/doc/book/pipeline/)

Prerequisites:
[Java](https://www.oracle.com/java/technologies/downloads/)
[Maven](https://maven.apache.org/install.html)
[Jekins](https://www.jenkins.io/doc/book/installing/)

### Demo 1 - add pipeline config to jenkins

`Jenkins` -> `Create Item` -> `Pipeline`
- check `github project`
  - Project url `https://github/your_github_repository`
- Pipeline
  - Definition: `Pipeline script`
  - Script: copy content from ./pipeline_project.groovy

### Demo 2 - run pipeline from Repository

`Jenkins` -> `Create Item` -> `Pipeline`
- check `github project`
  - Project url `https://github/your_github_repository`
- Pipeline
  - Definition: `Pipeline script from SCM`
    - SCM: `Git`
      - Repository URL: `https://github.com/Alex0424/CI-CD.git`
      - Branch: `*/main`
  - Script Path: `jenkins/pipeline/Jenkinsfile`
