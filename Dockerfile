# Base Image: Maven with OpenJDK 17
FROM maven:3.9.5-eclipse-temurin-17

# Update system and install required tools
RUN apt-get update && \
    apt-get install -y wget unzip xvfb && \
    apt-get install -y openjdk-17-jdk && \
    apt-get install -y libnss3 libx11-xcb1 libxcb1 libxcomposite1 libxrandr2 libxi6 libxtst6 libatk1.0-0 libgtk-3-0

# Install Google Chrome
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb || apt-get -f install -y && \
    rm google-chrome-stable_current_amd64.deb

# Install ChromeDriver
RUN wget https://chromedriver.storage.googleapis.com/$(wget -q -O - https://chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip && \
    mv chromedriver /usr/local/bin/ && \
    chmod +x /usr/local/bin/chromedriver && \
    rm chromedriver_linux64.zip

# Set working directory for the project
WORKDIR /workspace

# Copy project files
COPY . /workspace

# Default command (change if needed)
CMD ["bash"]
