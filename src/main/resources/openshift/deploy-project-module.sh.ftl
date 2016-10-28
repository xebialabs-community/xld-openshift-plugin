<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
set -e
<#if deployed.description?has_content>
    <#assign description=deployed.description />
<#else>
    <#assign description=deployed.projectName />
</#if>

<#if deployed.projectDisplayName?has_content>
    <#assign displayName=deployed.projectDisplayName />
<#else>
    <#assign displayName=deployed.projectName />
</#if>

<#include "/openshift/oc-login-deployed.ftl">

PROJECT_CONFIG=`${deployed.container.ocHome}/oc get projects ${deployed.projectName} | tail -1 | awk '{print $1}'`
if [ "$PROJECT_CONFIG" == "${deployed.projectName}" ];
then
    echo "Project already exists"
else
    ${deployed.container.ocHome}/oc new-project ${deployed.projectName} --description="${description}" --display-name="${displayName}"
fi;

${deployed.container.ocHome}/oc logout