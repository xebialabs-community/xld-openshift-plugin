<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
#!/bin/sh
set -e
<#assign container=deployed.container.server />
<#include "/openshift/oc-login-container.ftl">

${deployed.container.server.ocHome}/oc project ${deployed.container.projectName}

# determine if this app already exists, if not deploy a new one
echo "create new app automatically"
mkdir -p deployments
cp "${deployed.file.path}" deployments
${deployed.container.server.ocHome}/oc new-build --image-stream=${deployed.imageStream} --binary=true --name=${deployed.appName}
${deployed.container.server.ocHome}/oc start-build ${deployed.appName} --from-dir=.
${deployed.container.server.ocHome}/oc new-app --name=${deployed.appName}
${deployed.container.server.ocHome}/oc expose svc ${deployed.appName}
${deployed.container.server.ocHome}/oc status
rm -rf deployments
${deployed.container.server.ocHome}/oc logout
