<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
<#assign container=deployed.container.server />
<#include "/openshift/oc-login-container.ftl">

${deployed.container.server.ocHome}/oc project ${deployed.container.projectName} || goto :error

echo "Changing route"
echo "Check what status the app is in (blue or green)"
SET check=${deployed.container.server.ocHome}/oc get route ${deployed.appName} -o template --template="{{.spec.to.name}}" || echo "dummy"
if "%check%"=="${deployed.appName}-blue" (
    echo "App currently in blue state, routing to green"
    SET appName=${deployed.appName}-green
) else (
    echo "App currently in green state, routing to blue"
    SET appName=${deployed.appName}-blue
)
${deployed.container.server.ocHome}/oc patch route ${deployed.appName} -p {"spec":{"to":{"name":"%appName%"}}} || goto :error
${deployed.container.server.ocHome}/oc status || goto :error
${deployed.container.server.ocHome}/oc logout || goto :error
goto :EOF

<#include "/openshift/error.bat.ftl">
