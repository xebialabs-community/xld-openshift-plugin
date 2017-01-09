<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
<#include "/openshift/oc-login-previousDeployed.ftl">

${previousDeployed.container.ocHome}/oc delete project ${previousDeployed.projectName} || goto :error
${previousDeployed.container.ocHome}/oc logout || goto :error
goto :EOF

<#include "/openshift/error.bat.ftl">
