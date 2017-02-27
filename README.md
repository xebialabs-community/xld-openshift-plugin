# Preface #

This document describes the functionality provided by the XLD OpenShift plugin.

See the **XL Deploy Reference Manual** for background information on XL Deploy and deployment concepts.

# CI status #

[![Build Status][xld-openshift-plugin-travis-image]][xld-openshift-plugin-travis-url]
[![Codacy Badge][xld-openshift-plugin-codacy-image] ][xld-openshift-plugin-codacy-url]
[![Code Climate][xld-openshift-plugin-code-climate-image] ][xld-openshift-plugin-code-climate-url]

[xld-openshift-plugin-travis-image]: https://travis-ci.org/xebialabs-community/xld-openshift-plugin.svg?branch=master
[xld-openshift-plugin-travis-url]: https://travis-ci.org/xebialabs-community/xld-openshift-plugin
[xld-openshift-plugin-codacy-image]: https://api.codacy.com/project/badge/Grade/cbe6e057aa2f447c9d6e4a3092f192ad
[xld-openshift-plugin-codacy-url]: https://www.codacy.com/app/joris-dewinne/xld-openshift-plugin
[xld-openshift-plugin-code-climate-image]: https://codeclimate.com/github/xebialabs-community/xld-openshift-plugin/badges/gpa.svg
[xld-openshift-plugin-code-climate-url]: https://codeclimate.com/github/xebialabs-community/xld-openshift-plugin



# Overview #

This XLD OpenShift plugin supports v2 & v3 OpenShift implementations.  This plugin allows you to manage the deployment of OpenShift projects, containers and resources to your OpenShift infrastructure.  Additionally this plugin still supports doing WAR deployment to OpenShift JBoss gear. It uses rhc client to push to OpenShift environments.

# Requirements #

* **Requirements**
	* From version v7.x+, XLD 6.x is required.
	* **Remark**: version v7.x+ breaks compatibility with previous versions!
	* **rhc client on target machine for OpenShift v2**
	* **oc client on target machine for OpenShift v3**

# Installation #

Place the plugin xldp file into your `SERVER_HOME/plugins` directory.  For OpenShift v3 you will also need to install the [CLI](https://docs.openshift.org/latest/cli_reference/get_started_cli.html)
utility on a server.


# Usage #

## OpenShift v3

* OpenShift Containers

	* **openshift.Server**
	   The `openshift.server` represents the OpenShift server and is the container where the open shift `oc` commands will be exectued.  The `openshift.Server` container object is defined as follows:

	   `openshift.Server` extends `udm.BaseContainer`

	   | Properties     |           Description                                               |
	   |----------------|---------------------------------------------------------------------|
	   | host           | `overthere.Host` that contains the `openshift.Server`               |
	   | serverUrl      | URL to the OpenShift Admin Interface                                |
	   | ocHome         | The `HOME` directory where the `oc` client is installed             |
	   | installClient  | If true, the oc client will be downloaded, and placed under ocHome. |
	   | ocUrl          | Download url to get oc client                                       |
	   | skipTLS        | Set to true if you want to skip TLS verification                    |
	   | authentication | An enumeration of possible authentication types:<ul><li>Basic</li><li>Token</li><li>Basic Alias</li><li>Token Alias</li></ul>|
	   | username       | The username to authenticate to the OpenShift server                |
	   | password       | The password to authenticate to the OpenShift server                |
	   | openshiftToken | An OpenShift token for token authentication                         |
	   | credential     | A Custom `openshift.Credential` type                                |

	   Depending on the authentication method some of the properties will be required.  Required properties for specific authentication methods are as follows:

	   * **BASIC:**
	      * Username
	      * password
	   * **Token:**
	      * openshiftToken
	   * **Basic Alias:**
	      * credential `openshift.Credential`
	         * Username
	         * Password
	   * **Token Alias:**
	      * credential `openshift.Credential`
	         * Token

	   The `openshift.Server` has two control tasks that can be use to verify the configuration as follows:
	   * ***check:*** This control task will log into the OpenShift server using the **oc** command line tool to verify connectivity to the OpenShift server.
	   * **showResource:** This control task can be use to check on the available resources for a project.  You will be expect to provide a project name to execute this control task.

	   **Note**
       To install the `oc` client, on Unix hosts, the plugin will use `wget`that should be already installed.
       On Windows hosts, there are 2 options

       * use a version of `wget` bundled in the plugin and uploaded to perform the http request. (default option)
       * use a _different_ `wget` that is _already present_ on the path of your target systems you can simply prevent the included version from being uploaded by modifying `SERVER_HOME/conf/deployit-defaults.properties` as follows:
       ```
       	# Classpath Resources
       	# openshift.Server.wgetExecutable=openshift/runtime/wget.exe
       ```
       to
       ```
       	# Classpath Resources
       	openshift.Server.wgetExecutable=[Put your path here]
	   ```

    * **openshift.Project**
       An OpenShift project.  The project module is defined as follows:

       `openshift.Project` extends `udm.BaseContainer`

       | Properties      |         Description                      |
       |-----------------|------------------------------------------|
       | projectName     | A name for the project                   |
       | description     | A description of this project            |
       | projectDisplayName | A human readable name for the project |

* OpenShift Provisionables
    * **openshift.openshift.ProjectSpec**
       An OpenShift project spec.  The project spec is defined as follows:

       `openshift.ProjectSpec` extends `udm.BaseProvisionable`

       | Properties      |         Description                      |
       |-----------------|------------------------------------------|
       | projectName     | A name for the project                   |
       | description     | A description of this project            |
       | projectDisplayName | A human readable name for the project |

* OpenShift Deployables

    * **openshift.App**
       The OpenShift App is a container image that can be deployed from a registry.  By default XLD will deploy container images from the Docker Hub, but it is possible to supply and internal URL for a local repository.  The App module is defined as follows:

       `openshift.App` extends `udm.BaseDeployable`

       | Properties         |        Description                |
       |--------------------|-----------------------------------|
       | `Common`           | --------------------------------  |
       | appName            | OpenShift application name        |
       | project            | OpenShift project name.           |
       | `Docker`           | --------------------------------  |
       | dockerUrl          | Docker base url to be used.       |
       | dockerOrganization | Docker organization name.         |
       | dockerName         | Docker image name.                |
       | dockerTag          | Docker image tag.                 |

   * **openshift.DockerPushApp**
      The OpenShift DockerPushApp is similar to the openshift.App in that it is a container image that can be deployed from a registry.  The difference is that there is a docker pull to pull it from a central repository, tag the image, and then a push operation, pushing the image into Openshift.  This triggers a rolling deployment which is monitored by the plugin.   The DockerPushApp module is defined as follows:

      `openshift.DockerPushApp` extends `udm.BaseDeployable`

      | Properties             |            Description                      |
      |------------------------|---------------------------------------------|
      | `Common`               | ------------------------------------------  |
      | appName                | OpenShift application name                  |
      | project                | OpenShift project name.                     |
      | `Docker`               | ------------------------------------------  |
      | dockerUrl              | Docker base url to be used.                 |
      | dockerOrganization     | Docker organization name.                   |
      | dockerName             | Docker image name.                          |
      | dockerTag              | Docker image tag.                           |
	  | pullDockerUrl          | Docker base url to do a 'docker pull' from. |
	  | pullDockerOrganization | Docker organization name to pull.           |
	  | pullDockerName         | Docker image name to pull.                  |
	  | pullDockerTag          | Docker image tag to pull.                   |

    * **openshift.BinaryApp:**
      An OpenShift Binary App is an actual container file that should be deployed to a OpenShift project.  The Binary App module is defined as follows:

      `openshift.BinaryAppModule` extends `udm.BaseDeployableArtifact`

      |  Properties         |       Description                 |
      |---------------------|-----------------------------------|
      | appName             | OpenShift application name        |
      | project             | OpenShift project name.           |
      | imageStream         | The input stream to use as the builder |

    * **openshift.DockerfileApp:**
      An OpenShift Docker App is an actual Dockerfile that should be deployed to a OpenShift project.  The Dockerfile app module is defined as follows:

      `openshift.DockerfileAppModule` extends `udm.BaseDeployableArtifact`

      |  Properties         |       Description                 |
      |---------------------|-----------------------------------|
      | appName             | OpenShift application name        |
      | project             | OpenShift project name.           |

    * **openshift.ResourceModule:** The resource module defines the resources availble to the project.  The definition of the resources are defined in a YAML file attached to this deployable.  The Resource Modules is defined as follows:

      `openshift.ResourceModule` extends `udm.BaseDeployableArtifact`

      |  Properties         |       Description                 |
      |---------------------|-----------------------------------|
      | project             | OpenShift Project name            |
      | resourceYml         | YML file defining the resources   |



* OpenShift v2

# References #
+ CLI operations: [Basic intro](https://docs.openshift.org/latest/cli_reference/basic_cli_operations.html)
+ Blue-green: [Blue green deployments](https://blog.openshift.com/openshift-3-demo-part-10-blue-green-deployments/)
+ Routes:
    + [cli](https://docs.openshift.com/container-platform/latest/dev_guide/routes.html)
