<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->


echo "Copying ${deployed.file.name} to ${deployed.appName}___${deployed.container.name}/dependencies/jbossews/webapps/"
cd ${deployed.container.host.connection.options['tmp']}
mkdir -p ${deployed.appName}___${deployed.container.name}/dependencies/jbossews/webapps/
cp ${deployed.file.path} ${deployed.appName}___${deployed.container.name}/dependencies/jbossews/webapps/
