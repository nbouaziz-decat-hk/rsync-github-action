# Rsync Deployments

Rsync files from a GitHub repo to a destination server over SSH

## Required arguments

| Argument           | Description                                                                                                                                          |
|--------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| `RSYNC_OPTIONS`    | Rsync-specific options when running the command. Exclusions, deletions, etc      
| `SSH_PRIVATE_KEY`  | The private key part of an SSH key pair. The public key part should be added to the `authorized_keys` on the destination server. |
| `SSH_REMOTE_USER`     | The username to use when connecting to the destination server                                                                    |
| `SSH_REMOTE_HOST`     | The hostname of the destination server      |
| `TARGET_FOLDER`    | Where to deploy the files on the server                                                                                                              |
| `SOURCE_FOLDER`    | What files to deploy from the repo (starts at root) **NOTE**: a trailing `/` deploys the _contents_ of the directory instead of the entire directory |

## Example usage

```yaml

jobs:
  deploy:
    name: Deploy
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Deploy via rsync
        uses: dktunited/hk-rsync-github-action@master
        with:
          RSYNC_OPTIONS: -avzr --delete --exclude log --exclude tmp --exclude=".*"
          SOURCE_FOLDER: /path/to/target/folder/on/server
          TARGET_FOLDER: /src/public/
          SSH_PRIVATE_KEY: ${{secrets.SSH_PRIVATE_KEY}}
          SSH_REMOTE_USER: ${{secrets.SSH_USERNAME}}
          SSH_REMOTE_HOST: ${{secrets.SSH_HOSTNAME}}
```
