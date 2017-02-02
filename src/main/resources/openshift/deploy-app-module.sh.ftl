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
echo "create new app automatically"
<#if deployed.blueGreen>
    echo "Check what status the app is in (blue or green)"
    check=$(${deployed.container.server.ocHome}/oc get route ${deployed.appName} -o template --template="{{.spec.to.name}}") || echo "dummy"
    if [ "$check" = "${deployed.appName}-blue" ] ; then
        echo "App currently in blue state, creating green"
        appName=${deployed.appName}-green
    else
        echo "App currently in green state, creating blue"
        appName=${deployed.appName}-blue
    fi
<#else>
    appName=${deployed.appName}
</#if>
${deployed.container.server.ocHome}/oc new-app <#if deployed.dockerUrl?has_content>${deployed.dockerUrl}/</#if><#if deployed.dockerOrganization?has_content>${deployed.dockerOrganization}/</#if>${deployed.dockerName}<#if deployed.dockerTag?has_content>:${deployed.dockerTag}</#if> --name=$appName
${deployed.container.server.ocHome}/oc status
${deployed.container.server.ocHome}/oc logout
