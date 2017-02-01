<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
<#assign container=previousDeployed.container.server />
<#include "/openshift/oc-login-container.ftl">

${previousDeployed.container.server.ocHome}/oc project ${previousDeployed.container.projectName} || goto :error

${previousDeployed.container.server.ocHome}/oc delete all -l app=${previousDeployed.appName} || goto :error
${previousDeployed.container.server.ocHome}/oc logout || goto :error
goto :EOF

<#include "/openshift/error.bat.ftl">
