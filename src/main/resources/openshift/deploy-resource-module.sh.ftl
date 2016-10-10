<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->

set -e
<#include "/openshift/oc-login-deployed.ftl">

${deployed.container.ocHome}/oc project ${deployed.project}

# determine if this app already exists, if not deploy a new one
echo "create new resource"
${deployed.container.ocHome}/oc create -f ${deployed.file.path} -n ${deployed.project}
${deployed.container.ocHome}/oc status