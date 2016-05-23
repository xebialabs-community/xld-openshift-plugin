/**
 * THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
 * FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.
 */
package ext.deployit.community.plugin.openshift;

import com.xebialabs.deployit.plugin.api.udm.Metadata;
import com.xebialabs.deployit.plugin.api.udm.Property;
import com.xebialabs.deployit.plugin.api.udm.base.BaseConfigurationItem;

@SuppressWarnings("serial")
@Metadata(root = Metadata.ConfigurationItemRoot.CONFIGURATION, description = "A username, password token usable in an openshift.Server")
public class Credential extends BaseConfigurationItem {

    @Property(required= false)
    private String username;

    @Property(password = true, required= false)
    private String password;

    @Property(password = true, required= false)
    private String openshiftToken;

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getOpenShiftToken() {
        return openshiftToken;
    }
}
