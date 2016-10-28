<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
# login to openshift and switch projects
<#if deployed.container.authentication == "Basic">
${deployed.container.ocHome}/oc login --server=${deployed.container.serverUrl} -u=${deployed.container.username} -p="${deployed.container.password}" --insecure-skip-tls-verify=true
</#if>
<#if deployed.container.authentication == "Token">
${deployed.container.ocHome}/oc login --server=${deployed.container.serverUrl} --token=${deployed.container.openshiftToken} --insecure-skip-tls-verify=true
</#if>
<#if deployed.container.authentication == "Basic Alias">
${deployed.container.ocHome}/oc login --server=${deployed.container.serverUrl} -u=${deployed.container.credential.username} -p="${deployed.container.credential.password}" --insecure-skip-tls-verify=true
</#if>
<#if deployed.container.authentication == "Token Alias">
${deployed.container.ocHome}/oc login --server=${deployed.container.serverUrl} --token=${deployed.container.credential.openshiftToken} --insecure-skip-tls-verify=true
</#if>