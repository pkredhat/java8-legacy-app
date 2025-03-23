# Use Red Hat's official EAP base image
FROM registry.redhat.io/jboss-eap-7/eap73-openjdk11-openshift-rhel8:7.3.10-2

# Optional: Labels (for image metadata)
LABEL name="legacy-app" \
      maintainer="phknezev@redhat.com" \
      description="JBoss EAP legacy app container"

# Copy your WAR file into the deployments folder
COPY legacy-app.war /opt/eap/standalone/deployments/

# Optional: Touch .dodeploy to trigger deployment (some versions require this)
RUN touch /opt/eap/standalone/deployments/legacy-app.war.dodeploy