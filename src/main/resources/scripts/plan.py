#
# THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
# FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.
#

from java.util import HashMap
from java.util import HashSet

def sortDeployeds():
    deployedMap = HashMap()
    for _delta in deltas.deltas:
        deployed = _delta.deployedOrPrevious
        if deployed.type == "rh.TomcatWARModule":
	    key = deployed.appName + "___" + deployed.container.name
	    if deployedMap.containsKey(key):
		deployedMap.get(key).add(deployed)
	    else:
		result = HashSet()
		result.add(deployed)
		deployedMap.put(key, result)
    return deployedMap



deployedMap = sortDeployeds()
for app in deployedMap.entrySet():
    appsplit = app.key.rpartition("___")
    deployed1 = ""
    for d in app.value:
        deployed1 = d
	break;
    context.addStep(steps.os_script(
       description="Deploying Application %s on %s" % (appsplit[0],deployed1.container.id) ,
       script="scripts/deploy-artifact",
       freemarker_context={'deployeds':app.value,'appName':appsplit[0],'deployed1':deployed1},
       order=80,
       target_host = deployed1.container.host))
