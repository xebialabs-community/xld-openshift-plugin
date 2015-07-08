<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->

mkdir -p dependencies/jbossews/webapps/
echo "Wrapping artifacts for deployment"
<#list 1..count as d>
<#assign tempvar="deployed${d}.file.path" />
echo "Copying ${tempvar?eval} to dependencies/jbossews/webapps/"
cp ${tempvar?eval} dependencies/jbossews/webapps/
</#list>
tar -cvf ${appName}.tar dependencies
tar -tvf ${appName}.tar
gzip ${appName}.tar
rhc app-configure ${appName} --no-auto-deploy -l ${container.username} -p ${container.password}
rhc app-configure ${appName} --deployment-type binary -l ${container.username} -p ${container.password}
rhc app deploy --app ${appName} --ref ${appName}.tar.gz -l ${container.username} -p ${container.password}
