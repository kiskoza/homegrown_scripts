## Git Basic Settings

Copies basic git configurations to the right place

### How to use

```
./install.sh
```

### What does it do

1. Set up global git configs and aliases:
  - `cleanup`: remove already merged branches
  - `deploy-staging`: push HEAD to heroku-staging
  - `deploy-master`: push HEAD to heroku-master
2. Set up global gitignore
3. Set up pre-commit hooks
  - rubocop
  - haml-lint
  - scss-lint

