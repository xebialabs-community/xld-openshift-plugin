<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
<#assign container=previousDeployed.container.server />
<#include "/openshift/oc-login-container.ftl">

${previousDeployed.container.server.ocHome}/oc project ${previousDeployed.container.projectName} || goto :error

<#if previousDeployed.blueGreen>
    <#if operation?has_content>
        echo "Removing old app"
        SET check=${deployed.container.server.ocHome}/oc get route ${deployed.appName} -o template --template="{{.spec.to.name}}"
        if "%check%"=="${deployed.appName}-blue" (
            echo "App currently in blue state, removing green"
            SET appName=${deployed.appName}-green
        ) else (
            echo "App currently in green state, removing blue"
            SET appName=${deployed.appName}-blue
        )
    <#else>
        echo "Check what status the app is in (blue or green)"
        SET appName=${previousDeployed.container.server.ocHome}/oc get route ${previousDeployed.appName} -o template --template="{{.spec.to.name}}"
    </#if>
<#else>
    SET appName=${previousDeployed.appName}
</#if>

${previousDeployed.container.server.ocHome}/oc delete all -l app=%appName% || goto :error
${previousDeployed.container.server.ocHome}/oc logout || goto :error
goto :EOF

<#include "/openshift/error.bat.ftl">
