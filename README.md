## Summary
Development Containers Templates for predefined tools for CAP Development

## Installed Tools

* @sap/cds-dk version 8 or 9
* NodeJS Version 24 
* curl
* git
* sqlite3
* mbt
* Cloud Foundry CLI Version 8
* Cloud Foundry Plugins: multiapps, html5-plugin
* VSCode Extensions: 
    * "sapse.vscode-cds",
    * "dbaeumer.vscode-eslint",
    * "humao.rest-client",
    * "qwtel.sqlite-viewer",
    * "mechatroner.rainbow-csv",
    * "sapse.sap-ux-fiori-tools-extension-pack",
    * "github.copilot-chat"

## cap-tools

This template uses the devcontainer feature capability of DevContainers to configure installation of required tools.  The feature is located in the folder `.devcontainer/cap-tools` inside this repository. The following tools are available in cap-tools:
* install_cds_dk : Installs @sap/cds-dk of specified version (default: latest)
    * cds_dk_version : Version of @sap/cds-dk to be installed (default: latest)
* install_sqlite3 : Installs sqlite3 database (default: true)
* install_cf : Installs Cloud Foundry CLI version 8 along with multiapps and html5 plugins (default: true)
* install_mbt : Installs Multi-Target Application Build Tool (mbt)
