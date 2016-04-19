#
# THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
# FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.
#


from java.util import HashMap
from java.util import HashSet

def sort_deployeds():
    deployeds_per_key = HashMap()
    for _delta in deltas.deltas:
        deployed = _delta.deployedOrPrevious
        if deployed.type == "rh.TomcatWARModule":
            key = "%s___%s" % (deployed.appName, deployed.container.name)
            if deployeds_per_key.containsKey(key):
                deployeds_per_key.get(key).add(deployed)
            else:
                result = HashSet()
                result.add(deployed)
                deployeds_per_key.put(key, result)
    return deployeds_per_key



deployed_map = sort_deployeds()
for app in deployed_map.entrySet():
    appsplit = app.key.rpartition("___")
    containerObj = ""
    fc = {'appName':appsplit[0]}
    for d in app.value:
        containerObj = d.container
        break
    fc["container"] = containerObj
    context.addStep(steps.os_script(
       description="Deploying Application %s on %s" % (appsplit[0],containerObj.id) ,
       script="rhc/deploy-artifact",
       freemarker_context=fc,
       order=80,
       target_host = containerObj.host))
