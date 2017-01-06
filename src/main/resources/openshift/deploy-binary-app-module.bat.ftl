<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
<#include "/openshift/oc-login-deployed.ftl">

${deployed.container.ocHome}/oc project ${deployed.project}

<#-- determine if this app already exists, if not deploy a new one -->
echo "create new app automatically"
mkdir deployments
copy "${deployed.file.path}" deployments
${deployed.container.ocHome}/oc new-build --image-stream=${deployed.imageStream} --binary=true --name=${deployed.appName}
${deployed.container.ocHome}/oc start-build ${deployed.appName} --from-dir=.
${deployed.container.ocHome}/oc new-app --name=${deployed.appName}
${deployed.container.ocHome}/oc expose svc ${deployed.appName}
${deployed.container.ocHome}/oc status
rmdir /s /q deployments
${deployed.container.ocHome}/oc logout
