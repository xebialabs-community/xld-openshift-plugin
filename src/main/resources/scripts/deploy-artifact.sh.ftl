<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->



cd ${container.host.connection.options['tmp']}/${appName}___${container.name}
tar -cvf ${appName}.tar dependencies
tar -tvf ${appName}.tar
gzip ${appName}.tar
rhc app-configure ${appName} --no-auto-deploy -l ${container.username} -p ${container.password}
rhc app-configure ${appName} --deployment-type binary -l ${container.username} -p ${container.password}
rhc app deploy --app ${appName} --ref ${appName}.tar.gz -l ${container.username} -p ${container.password}
cd ..
rm -rf ${appName}___${container.name}
