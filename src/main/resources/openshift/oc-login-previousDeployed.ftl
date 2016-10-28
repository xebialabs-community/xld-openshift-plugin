<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
# login to openshift and switch projects
<#if previousDeployed.container.authentication == "Basic">
${previousDeployed.container.ocHome}/oc login --server=${previousDeployed.container.serverUrl} -u=${previousDeployed.container.username} -p="${previousDeployed.container.password}" --insecure-skip-tls-verify=true
</#if>
<#if previousDeployed.container.authentication == "Token">
${previousDeployed.container.ocHome}/oc login --server=${previousDeployed.container.serverUrl} --token=${previousDeployed.container.openshiftToken} --insecure-skip-tls-verify=true
</#if>
<#if previousDeployed.container.authentication == "Basic Alias">
${previousDeployed.container.ocHome}/oc login --server=${previousDeployed.container.serverUrl} -u=${previousDeployed.container.credential.username} -p="${previousDeployed.container.credential.password}" --insecure-skip-tls-verify=true
</#if>
<#if previousDeployed.container.authentication == "Token Alias">
${previousDeployed.container.ocHome}/oc login --server=${previousDeployed.container.serverUrl} --token=${previousDeployed.container.credential.openshiftToken} --insecure-skip-tls-verify=true
</#if>
