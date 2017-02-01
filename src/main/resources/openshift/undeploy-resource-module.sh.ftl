<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
#!/bin/sh
set -e
<#assign container=previousDeployed.container.server />
<#include "/openshift/oc-login-container.ftl">

# determine if this app already exists, if not deploy a new one
echo "destroy resource"
${previousDeployed.container.server.ocHome}/oc project ${previousDeployed.container.projectName}
${previousDeployed.container.server.ocHome}/oc delete -f ${previousDeployed.file.path}
${previousDeployed.container.server.ocHome}/oc status
${previousDeployed.container.server.ocHome}/oc logout
