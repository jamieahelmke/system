#!/bin/sh

# Install docker on debian based systems. If you don't want to install yacht too, set the flag below to false.
INSTALL_YACHT=true

RED="\033[0;31m"
YELLOW="\033[0;33m"
GREEN="\033[0;32m"
NC="\033[0m"

# Check if root
if [ "$(id -u)" != 0 ]; then
	echo "${RED}Please run as root!${NC}"
  exit
fi

### Installing dependencies
echo "\n${YELLOW}Installing dependencies...${NC}\n"
apt update || (echo "${RED}Error updating!${NC}"; exit 1)
apt install -y ca-certificates curl gnupg lsb-release || (echo "${RED}Error installing dependencies!${NC}"; exit 1)

### Installing keyring for docker
echo "\n${YELLOW}Installing keyring for docker...${NC}\n"
mkdir -p /etc/apt/keyrings
# Downloading the keyring
(curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg) || (echo "${RED}Error installing keyring!${NC}"; exit 1)
chmod a+r /etc/apt/keyrings/docker.gpg

### Adding docker to apt sources
echo "\n${YELLOW}Adding docker to apt sources...${NC}\n"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

### Installing docker
echo "\n${YELLOW}Installing docker...${NC}\n"
apt update || (echo "${RED}Error updating!${NC}"; exit 1)
apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin || (echo "${RED}Error installing docker!${NC}"; exit 1)
echo "\n${YELLOW}Enabling the docker service...${NC}\n"
service docker start || (echo "${RED}Error: Docker Service could not be started.${NC}"; exit 1)

echo "\n${GREEN}Docker was downloaded.${NC}\n"

### Running tests
echo "\n${YELLOW}Running final tests...${NC}\n"
# Check if the command is executable
command -v docker >/dev/null 2>&1 || (echo >&2 "There was an error installing docker. (Command not found)"; exit 1)
echo "\n${YELLOW}Running 'Hello World' Container...${NC}\n"
docker run --name hello-world-container hello-world || (echo "${RED}Error: 'Hello World' Container could not be started.${NC}"; exit 1)

install_yacht() {
  docker volume create yacht || (echo "${RED}Error: Volume for yacht could not be created."; exit 1)
  docker run -d -p 8000:8000 -v /var/run/docker.sock:/var/run/docker.sock -v yacht:/config --restart unless-stopped selfhostedpro/yacht || echo "${RED}Error: Yacht could not be started.${NC}"
}


if $INSTALL_YACHT; then
  install_yacht 
  docker ps -a
  echo "Yacht should be up and running.\nAccess yacht over port 8000 in your browser. (Login: admin@yacht.local), Password: pass"
fi

echo "\n${YELLOW}Removing 'Hello World' Container...${NC}\n"
docker rm hello-world-container

echo "\n${GREEN}Installation Completed!\nDocker was successfully installed. Type 'systemctl status docker' to see further information.${NC}\n"
exit 0;
