[![Build Status](https://travis-ci.org/serverdensity/sd-agent.svg?branch=master)](https://travis-ci.org/serverdensity/sd-agent)

This is the source code for the Server Density agent (v2). If you're looking to install the agent, we also provide [pre-packaged binaries](https://support.serverdensity.com/hc/en-us/articles/213625957-Officially-supported-Linux-distros) for most operating systems.

# Release notes
See [agent release notes](https://support.serverdensity.com/hc/en-us/articles/213513688-Agent-release-notes).

# Agent configuration

If you are using packages on Linux, the main configuration file can be found
in `/etc/sd-agent/config.cfg`. Per-check configuration files are in
`/etc/sd-agent/conf.d`. We provide an example in the same directory
that you can use as a template.

# [Agent plugins](https://support.serverdensity.com/hc/en-us/sections/202477098-Agent-Plugins)

## Installing plugins
See [information about agent plugins](https://support.serverdensity.com/hc/en-us/articles/212601137-Information-about-Agent-Plugins).

## Writing custom plugins
See [information about custom plugins](https://support.serverdensity.com/hc/en-us/articles/213074438-Information-about-Custom-Plugins).

# Legacy (v1) agent
Our legacy [v1 agent source code](https://github.com/serverdensity/sd-agent/tree/v1) is still available but will soon be sunset.

## Legacy plugins

We have maintained compatibility with the v1 agent's plugins. All
"old style" plugins are fully usable with the v2 agent.

See [information about custom plugins](https://support.serverdensity.com/hc/en-us/articles/213074438-Information-about-Custom-Plugins) for installation / configuration.

# Contributors

```bash
git log --all | gawk '/Author/ {print}' | sort | uniq
```
