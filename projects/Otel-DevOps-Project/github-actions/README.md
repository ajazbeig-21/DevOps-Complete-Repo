# GitHub Actions for CI/CD

## Introduction

GitHub Actions is a powerful automation tool provided by GitHub that enables continuous integration (CI) and continuous deployment (CD) directly within your repository. It allows you to automate workflows triggered by events like code pushes, pull requests, or scheduled times. GitHub Actions is particularly useful for the CI part of CI/CD pipelines, where it handles tasks such as code check-ins, static code analysis, running unit tests, building Docker images, scanning for vulnerabilities, and completing builds.

### Key Benefits
- **Integrated with GitHub**: No need for external CI/CD tools; everything is managed within your repository.
- **Event-Driven**: Workflows run automatically based on triggers like pushes or PRs.
- **Reusable Actions**: Leverage pre-built actions from the GitHub Marketplace or create custom ones.
- **Matrix Builds**: Test across multiple environments (e.g., different Node.js versions).
- **Free for Public Repos**: Generous free minutes for public repositories; paid plans for private ones.
- **Security**: Built-in secrets management and dependency scanning.

GitHub Actions supports a wide range of languages and frameworks, making it versatile for projects in Go, JavaScript, Python, etc.

## Setup

To set up GitHub Actions, create a `.github/workflows` directory in your repository root. Inside this directory, add YAML files (e.g., `ci.yml`) that define your workflows. GitHub provides pre-built actions like `actions/checkout` for cloning code, `docker/build-push-action` for building images, and many others.

### Basic Workflow Structure
A workflow is defined in a YAML file and consists of:
- **Name**: A descriptive name for the workflow.
- **On**: Triggers (e.g., `push`, `pull_request`).
- **Jobs**: A set of tasks to run, each on a specified runner (e.g., `ubuntu-latest`).
- **Steps**: Individual commands or actions within a job.

Example of a simple workflow file:

```yaml
name: CI Pipeline

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      - name: Set up Go
        uses: actions/setup-go@v4
        with:
          go-version: '1.21'
      - name: Build
        run: go build ./...
      - name: Run unit tests
        run: go test ./...
```

## Demo CI Workflow for Node.js App

Here's a complete example of a CI workflow for a Node.js-based application. This workflow includes checking out code, setting up Node.js, installing dependencies, running tests, building the app, and optionally building a Docker image.

Create a file named `.github/workflows/ci-node.yml` in your repository:

```yaml
name: Node.js CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [18.x, 20.x]
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Run linting
        run: npm run lint

      - name: Run tests
        run: npm test
        env:
          CI: true

      - name: Build application
        run: npm run build

  docker:
    needs: test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Log in to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Build and push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: myapp:latest
```

This workflow:
- Runs tests on multiple Node.js versions using a matrix strategy.
- Caches npm dependencies for faster builds.
- Builds a Docker image only on pushes to the main branch.
- Uses secrets for Docker credentials.

## Best Practices for GitHub Actions

- **Use Caching**: Cache dependencies (e.g., npm, pip) to speed up workflows.
- **Matrix Builds**: Test across multiple OS, versions, or environments.
- **Secrets Management**: Store sensitive data like API keys in repository secrets.
- **Workflow Optimization**: Use `needs` to run jobs in sequence and `if` conditions to control execution.
- **Security**: Pin action versions (e.g., `v4`) and review third-party actions.
- **Parallel Jobs**: Split tests into parallel jobs for faster execution.
- **Artifacts**: Upload build artifacts for later use or download.
- **Scheduled Workflows**: Use `schedule` for nightly builds or maintenance tasks.

## Common Interview Questions

1. **What is the difference between GitHub Actions and other CI/CD tools like Jenkins or CircleCI?**
   - GitHub Actions is tightly integrated with GitHub, making it easier for teams already using GitHub. It's event-driven and uses YAML for configuration, unlike Jenkins' Groovy scripts. It's free for public repos and has a marketplace for actions.

2. **How do you handle secrets in GitHub Actions?**
   - Use repository secrets or environment secrets. Access them via `${{ secrets.SECRET_NAME }}`. Never hardcode secrets in code.

3. **Explain the concept of a matrix build.**
   - A matrix allows running the same job across multiple configurations, like different Node.js versions or OS, to ensure compatibility.

4. **How can you optimize workflow run time?**
   - Use caching, parallel jobs, and conditional execution. Avoid unnecessary steps and leverage pre-built actions.

5. **What are GitHub Actions runners?**
   - Runners are machines (hosted by GitHub or self-hosted) that execute the workflow jobs. Hosted runners are available for Ubuntu, Windows, and macOS.

6. **How do you trigger a workflow manually?**
   - Use `workflow_dispatch` in the `on` section, allowing manual runs from the GitHub UI.

## Conclusion

GitHub Actions simplifies CI/CD by integrating directly with your GitHub repository. Mastering it involves understanding workflows, actions, and best practices, which are crucial for DevOps roles. For more details, refer to the [official GitHub Actions documentation](https://docs.github.com/en/actions).
