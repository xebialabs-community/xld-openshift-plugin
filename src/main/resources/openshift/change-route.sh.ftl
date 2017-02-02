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

echo "Changing route"
echo "Check what status the app is in (blue or green)"
check=$(${deployed.container.server.ocHome}/oc get route ${deployed.appName} -o template --template="{{.spec.to.name}}") || echo "dummy"
if [ "$check" = "${deployed.appName}-blue" ] ; then
    echo "App currently in blue state, routing to green"
    appName=${deployed.appName}-green
else
    echo "App currently in green state, routing to blue"
    appName=${deployed.appName}-blue
fi
jsonSpec={\"spec\":{\"to\":{\"name\":\"$appName\"}}}
jsonLabel={\"metadata\":{\"labels\":{\"app\":\"$appName\"}}}
${deployed.container.server.ocHome}/oc patch route ${deployed.appName} -p "$jsonSpec"
${deployed.container.server.ocHome}/oc patch route ${deployed.appName} -p "$jsonLabel"
${deployed.container.server.ocHome}/oc status
${deployed.container.server.ocHome}/oc logout
