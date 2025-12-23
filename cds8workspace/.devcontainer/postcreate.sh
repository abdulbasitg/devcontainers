 #!/usr/bin/bash 

npm install -g @sap/cds-dk@8

npm install -g mbt

wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo gpg --dearmor -o /usr/share/keyrings/cli.cloudfoundry.org.gpg

echo "deb [signed-by=/usr/share/keyrings/cli.cloudfoundry.org.gpg] https://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list

sudo apt-get update

sudo apt-get install cf8-cli

sudo cf add-plugin-repo CF-Community https://plugins.cloudfoundry.org
# Install the multiapps plugin; prefer the prebuilt ARM64 release when on arm64
ARCH=$(uname -m)
if [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
	TMP_BIN=/tmp/multiapps-plugin-non-static.linuxarm64
	echo "Downloading multiapps plugin for $ARCH to $TMP_BIN"
	curl -fsSL -o "$TMP_BIN" \
		"https://github.com/cloudfoundry/multiapps-cli-plugin/releases/latest/download/multiapps-plugin-non-static.linuxarm64"
	if [ -s "$TMP_BIN" ]; then
		chmod +x "$TMP_BIN"
		sudo cf install-plugin "$TMP_BIN" -f || sudo cf install-plugin -r CF-Community "multiapps"
		rm -f "$TMP_BIN"
	else
		echo "ARM64 binary download failed or empty; falling back to repo install"
		sudo cf install-plugin -r CF-Community "multiapps"
	fi
else
	# Non-ARM64 -> install from CF-Community repo
	sudo cf install-plugin -f -r CF-Community "multiapps"
fi

# Install the html5-plugin; prefer the prebuilt ARM64 release when on arm64
if [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
	HTML_BIN=/tmp/html5-plugin.linuxarm64
	echo "Attempting to download html5-plugin for $ARCH to $HTML_BIN"
		# Download the official SAP cf-html5-apps-repo CLI plugin (ARM64)
		HTML_BIN=/tmp/cf-html5-apps-repo-cli-plugin-linux-arm64
		echo "Downloading html5-plugin for $ARCH to $HTML_BIN"
		curl -fsSL -o "$HTML_BIN" \
			"https://github.com/SAP/cf-html5-apps-repo-cli-plugin/releases/latest/download/cf-html5-apps-repo-cli-plugin-linux-arm64" || true
	if [ -s "$HTML_BIN" ]; then
		chmod +x "$HTML_BIN"
		sudo cf install-plugin "$HTML_BIN" -f || sudo cf install-plugin -r CF-Community "html5-plugin"
		rm -f "$HTML_BIN"
	else
		echo "html5-plugin ARM64 download failed or empty; falling back to repo install"
		sudo cf install-plugin -r CF-Community "html5-plugin"
	fi
else
	sudo cf install-plugin -f -r CF-Community "html5-plugin"
fi