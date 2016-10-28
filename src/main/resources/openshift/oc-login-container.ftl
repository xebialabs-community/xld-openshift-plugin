<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
# login to openshift and switch projects
<#if container.authentication == "Basic">
${container.ocHome}/oc login --server=${container.serverUrl} -u=${container.username} -p="${container.password}" --insecure-skip-tls-verify=true
</#if>
<#if container.authentication == "Token">
${container.ocHome}/oc login --server=${container.serverUrl} --token=${container.openshiftToken} --insecure-skip-tls-verify=true
</#if>
<#if container.authentication == "Basic Alias">
${container.ocHome}/oc login --server=${container.serverUrl} -u=${container.credential.username} -p="${container.credential.password}" --insecure-skip-tls-verify=true
</#if>
<#if container.authentication == "Token Alias">
${container.ocHome}/oc login --server=${container.serverUrl} --token=${container.credential.openshiftToken} --insecure-skip-tls-verify=true
</#if>