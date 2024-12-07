# Base Image
FROM maven:3.9.5-eclipse-temurin-17 AS builder

# Install dependencies and Chrome
RUN apt-get update && \
    apt-get install -y wget unzip xvfb && \
    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb || apt-get -f install -y && \
    rm google-chrome-stable_current_amd64.deb

# Install ChromeDriver
RUN wget https://chromedriver.storage.googleapis.com/$(wget -q -O - https://chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip && \
    mv chromedriver /usr/local/bin/ && \
    chmod +x /usr/local/bin/chromedriver && \
    rm chromedriver_linux64.zip

# Set environment variables
ENV DISPLAY=:99
ENV CHROME_DRIVER=/usr/local/bin/chromedriver

# Set working directory
WORKDIR /workspace

# Copy project files
COPY . /workspace

# Run Maven to resolve dependencies
RUN mvn clean install

# Default command to start Selenium test
CMD ["mvn", "exec:java", "-Dexec.mainClass=com.example.selenium.App"]
