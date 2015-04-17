# Preface #

This document describes the functionality provided by the XLD Chef plugin.

See the **XL Deploy Reference Manual** for background information on XL Deploy and deployment concepts.

# Overview #

The XLD Chef plugin is a XL Deploy plugin that adds capability for rolling out Chef recipies on an overthere.Host.

# Requirements #

* **Requirements**
	* **XL Deploy** 4.5.0
	* **Chef** 

# Installation #

Place the plugin JAR file into your `SERVER_HOME/plugins` directory.  

# Usage #

1. Go to `Repository - Infrastructure`, create a new `overthere.Host`.
2. Create an environment under `Repository - Environments`
3. Create an application with `chef.Cookbook` as deployable.
4. Start deploying

_NOTE:_ To Use dicitionary substitution with this plugin in the Chef manifest files you will need to update the `conf/deployit-defaults.properties` file by adding two lines as follows:

`udm.BaseDeployableArchiveArtifact.scanPlaceholders=true
udm.BaseDeployableArchiveArtifact.textFileNamesRegex=.+\.(cfg | conf | config | ini | properties | props | txt | rb)
`
