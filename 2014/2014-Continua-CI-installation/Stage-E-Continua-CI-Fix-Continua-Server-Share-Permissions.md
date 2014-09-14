# Stage E: Fix Continua CI Server Share Permissions

By default the ContinuaCIShare has all permissions for `Everyone`. Usually this is not wise. Follow these steps to fix that.

## Step E00: Open the Share Properties of the shared folder
![E00-fix-permissions-share-properties.png](Stage-E-Continua-CI-Fix-Continua-Server-Share-Permissions\E00-fix-permissions-share-properties.png)

Then choose `Advances Sharing`.

## Step E01: In Advanced Sharing, fix the Permissions
![E01-fix-permissions-advanced-sharing.png](Stage-E-Continua-CI-Fix-Continua-Server-Share-Permissions\E01-fix-permissions-advanced-sharing.png)

Here choose `Permissions`.

## Step E02: fix permissions permissions `all`
![E02-fix-permissions-permissions-all.png](Stage-E-Continua-CI-Fix-Continua-Server-Share-Permissions\E02-fix-permissions-permissions-all.png)

Group `Everyone` has all permissions which is way too much. 

## Step E03: fix permissions permissions read
![E03-fix-permissions-permissions-read.png](Stage-E-Continua-CI-Fix-Continua-Server-Share-Permissions\E03-fix-permissions-permissions-read.png)

Lessen the permissions for 

## Step E04: Add Continua CI User
![E04-add-ContinuaCI-user.png](Stage-E-Continua-CI-Fix-Continua-Server-Share-Permissions\E04-add-ContinuaCI-user.png)

Optionally you can add the users (or domain groups) that need various permission levels to the `ContinuaCIShare` into separate local groups, and authorize these for the required permission levels in the next step.

## Step E05: Configure ContinuaCI User to have all permissions
![E05-fix-permissions-permissions-ContinuaCI-Full.png](Stage-E-Continua-CI-Fix-Continua-Server-Share-Permissions\E05-fix-permissions-permissions-ContinuaCI-Full.png)

## Step E06: Overview of All Permissions on the ContinuaCIShare share
![E06-fix-permissions-permissions-ContinuaCI-Full-applied.png](Stage-E-Continua-CI-Fix-Continua-Server-Share-Permissions\E06-fix-permissions-permissions-ContinuaCI-Full-applied.png)
