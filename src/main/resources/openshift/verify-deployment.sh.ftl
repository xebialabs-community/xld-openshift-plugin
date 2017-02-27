<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
#!/bin/sh
set -e

#############
# Variables #
#############
OC=${deployed.container.server.ocHome}/oc
TIME_INCREMENT=5    # How often to check on the deployment
TIMEOUT_MAX=1200    # How long to wait for a deployment to finish before declaring failure


<#assign container=deployed.container.server />
<#include "/openshift/oc-login-container.ftl">

$OC project ${deployed.container.projectName}

#Find the Replication Controller to watch
RC=${deployed.appName}-$($OC get dc ${deployed.appName} --template='{{range $index,$element := .}}{{if eq $index "status"}}{{range $index2,$element2 := .}}{{if eq $index2 "latestVersion"}}{{$element2}}{{end}}{{end}}{{end}}{{end}}')

echo "Watching $RC"

# Main script loop.  Loop from 0 to TIMEOUT_MAX counting by TIME_INCREMENT
for TIME in $(seq 0 $TIME_INCREMENT $TIMEOUT_MAX)
do
    STATUS=$($OC get rc $RC --template='{{$replicas := .status.fullyLabeledReplicas}}{{range $index,$element := .metadata.annotations}}{{if eq $index "openshift.io/deployment.phase"}}{{println $element "- Deploying Pod:" $replicas}}{{end}}{{end}}')
    echo $STATUS

    # f it is complete, all is well with the deployment
    if [[ $STATUS =~ "Complete" ]]; then
        echo "Deployment Success"
        $OC status
        $OC logout
        exit 0
    fi

    if [[ $STATUS =~ "Failed" ]]; then
        echo "Deployment failure"
        $OC status
        $OC logout
        exit 99
    fi

    # If we don't have 'Complete' or 'Failed' yet, it is in 'Pending' or 'Running' mode.  Keep waiting
    sleep $TIME_INCREMENT

done

# If we have made it here, TIMEOUT_MAX has been reached. Declare the deployment a failure
echo "Deployment Timed Out"
$OC status
$OC logout
exit 99
