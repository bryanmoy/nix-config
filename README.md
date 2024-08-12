# Nix Configuration

## Git: Set Multiple Remote URLs
```shell
git remote add all git@gitlab.com:bryanmoy/nix-config.git
git remote set-url --add --push all git@gitlab.com:bryanmoy/nix-config.git
git remote set-url --add --push all git@github.com:bryanmoy/nix-config.git
git remote set-url --add --push all git@codeberg.org:bryanmoy/nix-config.git
```
