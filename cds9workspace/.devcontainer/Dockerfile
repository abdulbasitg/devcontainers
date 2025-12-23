# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:24

# Install some generally useful tools
RUN apt-get update && apt-get -y install --no-install-recommends curl git sqlite3

# Install SAP CAP SDK globally
USER node
#RUN npm install -g @sap/cds-dk
WORKDIR /home/node