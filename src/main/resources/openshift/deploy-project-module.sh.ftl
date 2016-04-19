<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
<#if deployed.description?has_content>
    <#assign description=deployed.description />
<#else>
    <#assign description=deployed.projectName />
</#if>

<#if deployed.projectDisplayName?has_content>
    <#assign displayName=deployed.projectDisplayName />
<#else>
    <#assign displayName=deployed.projectName />
</#if>

# login to openshift
oc login --server=${deployed.container.serverUrl} -u ${deployed.container.username} -p ${deployed.container.password} --insecure-skip-tls-verify=true

PROJECT_CONFIG=`oc get projects | grep "${deployed.projectName}" | tail -1 | awk '{print $1}'`
if [ "$PROJECT_CONFIG" == "${deployed.projectName}" ];
then
    echo "Project already exists"
else
    oc new-project ${deployed.projectName} --description="${description}" --display-name="${displayName}"
fi;