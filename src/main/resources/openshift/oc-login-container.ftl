<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
<#-- login to openshift and switch projects -->
<#if container.host.os == "UNIX">
    export KUBECONFIG=./config
</#if>
<#if container.host.os == "WINDOWS">
    @echo off
    set KUBECONFIG=./config
</#if>

<#-- Token based authentication -->
<#if container.authentication == "Token">
    <#assign token=container.openshiftToken />
</#if>
<#if container.authentication == "Token Alias">
    <#assign token=container.credential.openshiftToken />
</#if>
<#if container.authentication == "Token" || container.authentication == "Token Alias">
    ${container.ocHome}/oc login --server=${container.serverUrl} --token=${token} --insecure-skip-tls-verify=${container.skipTLS?c}
</#if>

<#-- Username / password authentication -->
<#if container.authentication == "Basic">
    <#assign username=container.username />
    <#assign password=container.password />
</#if>
<#if container.authentication == "Basic Alias">
    <#assign username=container.credential.username />
    <#assign password=container.credential.password />
</#if>
<#if container.authentication == "Basic" || container.authentication == "Basic Alias">
    <#if container.host.os == "WINDOWS">
        ${container.ocHome}/oc login --server=${container.serverUrl} -u=${username} -p="${password}" --insecure-skip-tls-verify=${container.skipTLS?c}
    </#if>
    <#if container.host.os == "UNIX">
        ${container.ocHome}/oc login --server=${container.serverUrl} -u=${username} -p='${password}' --insecure-skip-tls-verify=${container.skipTLS?c}
    </#if>
</#if>

