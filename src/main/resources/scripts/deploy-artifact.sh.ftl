<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->

echo "Wrapping ${deployed.file.name} to tar.gz"
mkdir -p dependencies/jbossews/webapps/
cp ${deployed.file.name} dependencies/jbossews/webapps/
tar -cvf ${deployed.name}.tar dependencies
gzip ${deployed.name}.tar
rhc app-configure ${deployed.appName} --no-auto-deploy -l ${deployed.container.username} -p ${deployed.container.password}
rhc app-configure ${deployed.appName} --deployment-type binary -l ${deployed.container.username} -p ${deployed.container.password}
rhc app deploy --app ${deployed.appName} --ref ${deployed.name}.tar.gz -l ${deployed.container.username} -p ${deployed.container.password} 

