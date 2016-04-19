# login to openshift and switch projects
oc login --server=${previousDeployed.container.serverUrl} -u ${previousDeployed.container.username} -p ${previousDeployed.container.password} --insecure-skip-tls-verify=true

oc delete project ${previousDeployed.projectName}