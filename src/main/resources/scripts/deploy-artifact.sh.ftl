<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->


mkdir -p dependencies/jbossews/webapps/
echo "Wrapping artifacts for deployment"
<#list deployeds as d>
echo "Copying ${d.file.path} to dependencies/jbossews/webapps/"
cp ${d.file.path} dependencies/jbossews/webapps/
</#list>
tar -cvf ${appName}.tar dependencies
tar -tvf ${appName}.tar
gzip ${appName}.tar
rhc app-configure ${appName} --no-auto-deploy -l ${deployed1.container.username} -p ${deployed1.container.password}
rhc app-configure ${appName} --deployment-type binary -l ${deployed1.container.username} -p ${deployed1.container.password}
rhc app deploy --app ${appName} --ref ${appName}.tar.gz -l ${deployed1.container.username} -p ${deployed1.container.password}

