# Local GitHub Actions Testing with ACT

This project uses [`nektos/act`](https://github.com/nektos/act) to run GitHub Actions locally

## Requirements

- [Docker](https://docs.docker.com/get-docker/) installed and running.
- [Homebrew](https://brew.sh/) installed.  
  (See [Homebrew on Linux](https://docs.brew.sh/Homebrew-on-Linux) if you are on Linux)
- Install `act` using Homebrew:

  ```bash
  brew install act
  ```

## Common Commands that you would probably use

- Run all workflows:

  ```bash
  act
  ```

- Run workflows with secrets from a file:

  ```bash
  act --secret-file .secrets
  ```

- Run a specific job:

  ```bash
  act -j job-name
  ```

- Visualize job dependencies:

  ```bash
  act --graph
  ```

- Do not delete containers use on the CI for reusing them (eco friendly!! xd):

  ```bash
  act -r
  ```

- Use external personalize image for the container, one developed from you:

  ```bash
  act -P ubuntu-latest=your-image:version-tag
  ```