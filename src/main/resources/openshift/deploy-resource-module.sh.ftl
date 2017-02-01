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
echo "create new resource"
${deployed.container.server.ocHome}/oc create -f ${deployed.file.path} -n ${deployed.container.projectName}
${deployed.container.server.ocHome}/oc status
${deployed.container.server.ocHome}/oc logout
