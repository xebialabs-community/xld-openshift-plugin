# Preface #

This document describes the functionality provided by the XLD OpenShift plugin.

See the **XL Deploy Reference Manual** for background information on XL Deploy and deployment concepts.

# CI status #

[![Build Status][xld-openshift-travis-image]][xld-openshift-travis-url]
[![Codacy Badge][xld-openshift-codacy-image] ][xld-openshift-codacy-url]
[![Code Climate][xld-openshift-code-climate-image] ][xld-openshift-code-climate-url]

[xld-openshift-travis-image]: https://travis-ci.org/xebialabs-community/xld-openshift-plugin.svg?branch=master
[xld-openshift-travis-url]: https://travis-ci.org/xebialabs-community/xld-openshift-plugin
[xld-openshift-codacy-image]: https://api.codacy.com/project/badge/Grade/cbe6e057aa2f447c9d6e4a3092f192ad
[xld-openshift-codacy-url]: https://www.codacy.com/app/joris-dewinne/xld-openshift-plugin
[xld-openshift-code-climate-image]: https://codeclimate.com/github/xebialabs-community/xld-openshift-plugin/badges/gpa.svg
[xld-openshift-code-climate-url]: https://codeclimate.com/github/xebialabs-community/xld-openshift-plugin



# Overview #

This XLD OpenShift plugin is capable of doing WAR deployment to OpenShift JBoss gear. It uses rhc client to push to OpenShift environments.
Starting from version 6.0.0, OpenShift v3 is also part of this plugin.

# Requirements #

* **Requirements**
	* **XL Deploy** 5.1.3+
	* **rhc client on target machine for OpenShift v2** 
	* **oc client on target machine for OpenShift v3** 

# Installation #

Place the plugin xldp file into your `SERVER_HOME/plugins` directory.  

# Usage #

