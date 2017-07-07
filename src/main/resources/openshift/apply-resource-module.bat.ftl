<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
<#assign container=deployed.container />
<#include "/openshift/oc-login-container.ftl">

${deployed.container.ocHome}/oc project ${deployed.project} || goto :error

echo "apply modified resource"
${deployed.container.ocHome}/oc apply -f ${deployed.file.path} -n ${deployed.project} || goto :error
${deployed.container.ocHome}/oc status || goto :error
${deployed.container.ocHome}/oc logout || goto :error
goto :EOF

<#include "/openshift/error.bat.ftl">
