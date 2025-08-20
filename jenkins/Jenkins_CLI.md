# Jenkins CLI

## Setup

go to `http://localhost:8080/manage/cli/` to download and run Jenkins CLI.

All the available commands should be listed on this page.

## Commands

### Build Jobs

```shell
java -jar jenkins-cli.jar -s http://localhost:8080/ build MyJob -v -s --username admin --password 1234
```

## Build With Parameters

```shell
java -jar jenkins-cli.jar -s http://localhost:8080/ build ParameterizedProject -v -s --username admin --password 1234 -p platform="Linux" -p choice="A"
```