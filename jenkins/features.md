# Features

## Create Item

### There are six ways to create an item
- Freestyle project. 
- Pipeline
- Multi-configuration project
- Folder
- Multibranch Pipeline
- Organization Folder

## Job options

### General
- Discard old builds
- GitHub project
- This project is parameterised
- Throttle builds
- Execute concurrent builds if necessary

### Source Code Management


### Triggers
- Trigger build remotely
  - by refreshing a specific URL (e.g.: by a script)
- Build after other projects are built
  - Trigger after parent projects/jobs build is "stable"/"even if unstable"/"even if fails"
- Build periodically
  - Cron timeformat e.g.: `* * * * *`
- GitHub hook trigger for GITScm polling
- Poll SCM

### Environment
- Delete workspace before build starts
  - Clear all files in the Jenkins runner job path environment e.g.: `/var/lib/jenkins/workspace/JavaHelloWorld`

```
┌───────────── minute (0 - 59)
│ ┌───────────── hour (0 - 23)
│ │ ┌───────────── day of the month (1 - 31)
│ │ │ ┌───────────── month (1 - 12)
│ │ │ │ ┌───────────── day of the week (0 - 6, Sunday is 0 or 7)
│ │ │ │ │
* * * * *
```

- Use secret text(s) or file(s)
- Add timestamps to the Console Output
- Inspect build log for published build scans
- Terminate a build if it's stuck
- With Ant


### Build Steps
- Execute Shell
- Invoke Ant

### Post Build Actions
- Build other project
  - When complete run other projects(child projects/jobs) only if build is "stable"/"even if unstable"/"even if fails"

## System

`Jenkins` -> `Manage Jenkins` -> `System`

- Environment variables
  - add `name/key` & `value` attributes
- Usage Statistics
  - Disable/Enable Jenkins statistics
- Time Stamper
  - System clock format
- Jenkins URL
  - Switch domain
- Administrative monitors
  - pick what warnings should be enabled
- System Admin e-mail address
- GitHub Servers
  - provide github servers credentials
- Pipeline Configuration
- Build-timeout Plugin > BuildStep Action

## Security

`Jenkins` -> `Manage Jenkins` -> `Security`

