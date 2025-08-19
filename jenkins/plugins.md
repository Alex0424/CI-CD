# Plugins

## Role-based Authorization Strategy
- Enables user authorization using a Role-Based strategy. Roles can be defined globally or for particular jobs or nodes selected by regular expressions.

Enable authorization
- go to `Manage Jenkins` -> `Security` -> `Role Based Strategy` -> Click on activate/enable.
- go to `Manage Jenkins` -> `Manage and Assign Roles` -> `Manage Roles` -> Add your roles and access here.
  - Item Roles: | Role: `java-developer` | Pattern: `JavaProject.*` (Java devs would only see items that are named with the specified pattern)
- go to `Manage Jenkins` -> `Manage and Assign Roles` -> `Assign Roles` -> Assign the roles to selected users.