# Preface #

This document describes the functionality provided by the XLD OpenShift plugin.

See the **XL Deploy Reference Manual** for background information on XL Deploy and deployment concepts.

# CI status #

[![Build Status][xld-advanced-command-travis-image]][xld-advanced-command-travis-url]

[xld-advanced-command-travis-image]: https://travis-ci.org/xebialabs-community/xld-openshift-plugin.svg?branch=master
[xld-advanced-command-travis-url]: https://travis-ci.org/xebialabs-community/xld-openshift-plugin


# Overview #

This XLD OpenShift plugin is capable of doing WAR deployment to OpenShift JBoss gear. It uses rhc client to push to OpenShift environments.
Starting from version 6.0.0, OpenShift v3 is also part of this plugin.

# Requirements #

* **Requirements**
	* **XL Deploy** 4.5.0+
	* **rhc client on target machine for OpenShift v2** 

# Installation #

Place the plugin xldp file into your `SERVER_HOME/plugins` directory.  

# Usage #

