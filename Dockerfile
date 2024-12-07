# Use Maven with OpenJDK 17 as the base image
FROM maven:3.9.5-eclipse-temurin-17

# Update system and install necessary dependencies for Chromium
RUN apt-get update && \
    apt-get install -y wget unzip xvfb && \
    apt-get install -y chromium chromium-driver && \
    apt-get install -y openjdk-17-jdk && \
    apt-get install -y libnss3 libx11-xcb1 libxcb1 libxcomposite1 libxrandr2 libxi6 libxtst6 libatk1.0-0 libgtk-3-0

# Set environment variables for Chrome/Chromium
ENV DISPLAY=:99
ENV CHROME_BIN=/usr/bin/chromium
ENV CHROMEDRIVER_PATH=/usr/lib/chromium-browser/chromedriver

# Set the working directory for the project
WORKDIR /workspace/selenium-test

# Copy project files into the workspace
COPY . /workspace/selenium-test

# Default command (can be changed based on your needs)
CMD ["bash"]
