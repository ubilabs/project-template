# {{project-name}}

## Description

{{project-description}}

### Links

* Staging: http://staging.domain.com/?debug=true
* Live: http://domain.com/

### Team

* PM Ubilabs: Name <name@ubilabs.net>
* PM Client: Name <name@domain.com>

## Development

### Prerequisites
Make sure you have the following tools installed:

* git
* npm

### Installation

After cloning the repository, install all dependencies:

```sh
npm install # install new dependencies
```

### Develop

Run the following command to start the server on localhost:

```sh
npm start # start the server
```

### Deploy

To deploy the application, run the following commands:

```sh
npm run build
npm run deploy
```

### Release

The release process should look like this:

1. Create a new release branch
2. Bump version via:
  ```sh
  npm version [major | minor | patch]
  ```
3. Push the created commit & the new git tag:
  ```sh
  git push -u origin <release-branch> && git push --tags
  ```
4. Merge the release branch using a pull request
5. Checkout the `master` branch and get it update to date
6. **optional:** [Deploy](#deploy) the new version from `master`

## Hosting

The project is hosted at [whereever.com](http://whereever.com)
