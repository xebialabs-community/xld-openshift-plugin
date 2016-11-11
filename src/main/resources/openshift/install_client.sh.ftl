<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
#!/bin/sh
set -e

if [ -e "${container.ocHome}/oc" ]
then
    echo "OpenShift client already installed."
else
    echo "Installing OpenShift client."
    wget -O oclient.tar.gz ${container.ocUrl}
    mkdir -p ${container.ocHome}
    tmpdir=$( mktemp -d )
    tar -xvf oclient.tar.gz -C $tmpdir
    find $tmpdir -type f -exec mv -i {} ${container.ocHome} \;
fi


