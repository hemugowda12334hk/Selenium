# Base Image
FROM maven:3.9.5-eclipse-temurin-17

# Install essential tools and Chrome
RUN apt-get update && \
    apt-get install -y git wget unzip xvfb && \
    apt-get install -y openjdk-17-jdk && \
    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb || apt-get -f install -y && \
    rm google-chrome-stable_current_amd64.deb

# Install ChromeDriver
RUN wget https://chromedriver.storage.googleapis.com/$(wget -q -O - https://chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip && \
    mv chromedriver /usr/local/bin/ && \
    chmod +x /usr/local/bin/chromedriver && \
    rm chromedriver_linux64.zip

# Set working directory
WORKDIR /workspace

# Copy project files
COPY . /workspace

# Resolve Maven dependencies
RUN mvn clean install

# Default command
CMD ["mvn", "exec:java", "-Dexec.mainClass=com.example.selenium.App"]
