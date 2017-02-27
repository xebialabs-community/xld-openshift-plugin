<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
#!/bin/sh
set -e

DOCKER_FROM=<#if deployed.pullDockerUrl?has_content>${deployed.pullDockerUrl}/</#if><#if deployed.pullDockerOrganization?has_content>${deployed.pullDockerOrganization}/</#if>${deployed.pullDockerName}<#if deployed.pullDockerTag?has_content>:${deployed.pullDockerTag}</#if>
DOCKER_TO=<#if deployed.dockerUrl?has_content>${deployed.dockerUrl}/</#if><#if deployed.dockerOrganization?has_content>${deployed.dockerOrganization}/</#if>${deployed.dockerName}<#if deployed.dockerTag?has_content>:${deployed.dockerTag}</#if>

echo "Pulling image from:  $DOCKER_FROM"
echo "  Pushing image to:  $DOCKER_TO"
docker pull $DOCKER_FROM
docker tag $DOCKER_FROM $DOCKER_TO
docker push $DOCKER_TO
