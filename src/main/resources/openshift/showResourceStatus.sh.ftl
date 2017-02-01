<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
#!/bin/sh
set -e
<#assign container=container.server />
<#include "/openshift/oc-login-container.ftl">

${container.server.ocHome}/oc describe quota -n ${params.projectName}
${container.server.ocHome}/oc logout


