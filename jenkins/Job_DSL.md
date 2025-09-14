# Job DSL

**Jenkins Job DSL Videos:**

- https://youtu.be/91XfkLal3WI
- https://youtu.be/nyWn54zRttQ
- https://youtu.be/pSEGc4U7IbY
- https://youtu.be/nMwR9jqCRTI

## What is Job DSL in Jenkins?

Jenkins Job DSL was created to make it easier to manage jobs.
- When jobs grow, maintaining becomes difficult and alot of work
  - Jenkins Job DSL plugin solves this problem with alot of extra benefits:
    - Version Control
    - History
    - Audit Log
    - Easier job restore when something goes wrong

The pipeline is a specific job type that can be created using the Jenkins UI or the Jenkins Job DSL.

You can write the pipeline in Jenkins DSL (declarative pipeline) or in groovy (scripted pipeline).
- Groovy is a scripting language for the java plattform, similar to java syntax but it runs in JVM (Java Virtual Machine).
- Under the hood the Jenkins DSL in interpreted by groovy.

Job DSL creates jobs based on what code you write.

## Getting Started

1. install the Job DSL plugin on your Jenkins instance.

2. create a "seed job" that runs the Job DSL scripts to generate other jobs.
