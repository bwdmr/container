# Devcontainer


## About
VSCode Development Container.

## Usage
concatenate your Dockerfile from the components within the `Library`-Folder.
Create a File, within the root of your projects folder, it represents the contents of a Dockerfile running the container:
```json
// .devcontainer.json
{
  "build": {
    "dockerfile": "Devcontainer/Dockerfile",
  },
  "extensions": [
    "james-yu.latex-workshop",
	],
	"workspaceMount": "source=/Users/[REDACTED]/projects,target=/workspace,type=bind",
	"workspaceFolder": "/workspace",
	"containerUser": "user",
	"runArgs": [
		"--network=host"
	],
	"portsAttributes": {
		"5000": {
			"label": "5001"
		}
	}
}
```

The Dockerfile listed is an Example on how to compose such a file.

## Links
- https://code.visualstudio.com/docs/devcontainers/containers
