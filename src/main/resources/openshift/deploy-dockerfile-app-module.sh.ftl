<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
#!/bin/sh
set -e
<#assign container=deployed.container />
<#include "/openshift/oc-login-container.ftl">

${deployed.container.ocHome}/oc project ${deployed.project}

echo "Check if build config already exists"
check=$(${deployed.container.ocHome}/oc get bc ${deployed.appName} --output=name | grep ${deployed.appName}) || echo "nobuildconfig"
expected =buildconfig/${deployed.appName}
if [ "$check" = "$expected" ] ; then
    echo "Build config already exists"
    ${deployed.container.ocHome}/oc start-build ${deployed.appName} --from-dir=${deployed.file.path} --follow=true
else
    echo "Build config doesn't exist yet. Creating."
    ${deployed.container.ocHome}/oc new-build --strategy=docker --binary=true --name=${deployed.appName}
    ${deployed.container.ocHome}/oc start-build ${deployed.appName} --from-dir=${deployed.file.path} --follow=true
    ${deployed.container.ocHome}/oc new-app --name=${deployed.appName}
    ${deployed.container.ocHome}/oc expose svc ${deployed.appName}
fi

${deployed.container.ocHome}/oc status
${deployed.container.ocHome}/oc logout
