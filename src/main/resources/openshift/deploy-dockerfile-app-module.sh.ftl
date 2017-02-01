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

echo "Check if build config already exists"
check=$(${deployed.container.server.ocHome}/oc get bc ${deployed.appName} --output=name | grep ${deployed.appName}) || echo "nobuildconfig"
expected=buildconfig/${deployed.appName}
if [ "$check" = "$expected" ] ; then
    echo "Build config already exists"
    ${deployed.container.server.ocHome}/oc start-build ${deployed.appName} --from-file=${deployed.file.path} --follow=true
else
    echo "Build config doesn't exist yet. Creating."
    ${deployed.container.server.ocHome}/oc new-build --strategy=docker --binary=true --name=${deployed.appName}
    ${deployed.container.server.ocHome}/oc start-build ${deployed.appName} --from-file=${deployed.file.path} --follow=true
    ${deployed.container.server.ocHome}/oc new-app --name=${deployed.appName}
    ${deployed.container.server.ocHome}/oc expose svc ${deployed.appName}
fi

${deployed.container.server.ocHome}/oc status
${deployed.container.server.ocHome}/oc logout
