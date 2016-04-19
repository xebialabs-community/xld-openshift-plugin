<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->


# login to openshift and switch projects
oc login --server=${deployed.container.serverUrl} -u ${deployed.container.username} -p ${deployed.container.password} --insecure-skip-tls-verify=true
oc project ${deployed.project}

# determine if this app already exists, if not deploy a new one
BUILD_CONFIG=`oc get dc | grep "${deployed.appName} | tail -1 | awk '{print $1}'`
if [ "$BUILD_CONFIG" == "${deployed.appName}" ]; then
    # import new docker image into project (kicks off deployment)
    oc import-image ${deployed.appName}
else
    # create new app automatically
    oc new-app <#if deployed.dockerUrl?has_content>${deployed.dockerUrl}/</#if><#if deployed.dockerOrganization?has_content>${deployed.dockerOrganization}/</#if>$deployed.dockerName<#if deployed.dockerTag?has_content>:${deployed.dockerTag}</#if> --name=${deployed.appName}
    oc expose service ${deployed.appName}
fi;