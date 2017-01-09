<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
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

<#assign container=deployed.container />
<#include "/openshift/oc-login-container.ftl">

${deployed.container.ocHome}/oc new-project ${deployed.projectName} --description="${description}" --display-name="${displayName}" || goto :error
${deployed.container.ocHome}/oc logout || goto :error
goto :EOF

<#include "/openshift/error.bat.ftl">
