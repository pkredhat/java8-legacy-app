#!/bin/bash

# Variables (edit these if needed)
EAP_HOME=~/EAP-7.3.0
SERVLET_API="$EAP_HOME/modules/system/layers/base/javax/servlet/api/main/jboss-servlet-api_4.0_spec-2.0.0.Final-redhat-00001.jar"
DEPLOYMENTS_DIR="$EAP_HOME/standalone/deployments"
WAR_NAME="legacy-app.war"
MTA_CLI=~/Downloads/mta-7.2.1-cli-darwin-amd64/darwin-mta-cli
MTA_OUTPUT=~/Downloads/amt-report

# Step 1: Compile Servlet
echo "Compiling servlet..."
javac -cp "$SERVLET_API" \
  -d build/classes \
  src/com/legacy/servlets/HelloServlet.java

# Step 2: Create WAR file
echo "Creating WAR file..."
rm -f "$WAR_NAME"
mkdir -p WEB-INF/classes
cp -r build/classes/com WEB-INF/classes/
cp WebContent/WEB-INF/web.xml WEB-INF/
jar -cvf "$WAR_NAME" WEB-INF
rm -rf WEB-INF

# Step 3: Deploy WAR file
echo "Deploying WAR file..."
rm -rf "$DEPLOYMENTS_DIR/$WAR_NAME"*
cp "$WAR_NAME" "$DEPLOYMENTS_DIR"

# Step 4: Run AMT analysis
echo "Running AMT analysis..."
mkdir -p ~/.kantra
cp -R ~/Downloads/mta-7.2.1-cli-darwin-amd64/* ~/.kantra/

"$MTA_CLI" analyze \
  --input . \
  --output "$MTA_OUTPUT" \
  --mode source-only \
  --overwrite \
  --target eap7 \
  --target eap8 \
  --provider java \
  --enable-default-rulesets

echo "✅ Deployment and AMT analysis completed! Report available at $MTA_OUTPUT/index.html"
echo "Deployment URL: http://localhost:8080/legacy-app/hello?user=TestUser"