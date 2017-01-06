#
# THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
# FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.
#

from java.util import HashSet

def containers():
    result = HashSet()
    for _delta in deltas.deltas:
        deployed = _delta.deployedOrPrevious
        current_container = deployed.container
        if _delta.operation != "NOOP" and current_container.type == "openshift.Server" and current_container.installClient:
            result.add(current_container)
    return result


for container in containers():
    context.addStep(steps.os_script(
        description="Installing client on server %s" % container.name,
        order=20,
        script="openshift/install_client",
        freemarker_context={'container': container},
        target_host=container.host,
        classpath_resources=["openshift/runtime/wget.exe"])
    )
