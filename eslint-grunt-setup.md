# Setup eslint as Grunt Task and pre-commit hook

## Grunt task

### Dependencies

* Grunt >4.2.0
* grunt-eslint ^6.0.0

### Add eslintrc

Add the .eslintrc from [here](https://raw.github.com/ubilabs/ubilabs-project-template/master/.eslintrc) to your project folder and adjust to your needs.

### Grunt setup

Add or modify the eslint task in the Gruntfile.js:

```
eslint: {
  options: {
    configFile: '.eslintrc',
    format: 'stylish'
  },
  target: [
    '<%= folders.app %>/scripts/**/*js',
    'Gruntfile.js',
    'tasks/**/*.js',
    'test/**/*.js'
  ]
}
```

Since we are using the eslint tool for [sublime](https://github.com/ubilabs/SublimeLinter) we only need to setup eslint to run on build. So put your eslint task in the task.run array of you build task.
We can use this task later in the pre-commit hook.

## Pre-commit Hook

We have to add the git hook at least every time we check out a git project since the hook are not included in the repo.

To add a git hook that starts a grunt task (our eslint from above) we use the `grunt-githooks` module.

Add the necessary dependencies to `package.json`:

```
npm install grunt-githooks --save-dev
```

Adjust the `Gruntfile.js` with the new task:

```
githooks: {
  all: {
    'pre-commit': 'eslint',
  }
}
```

Add githooks task to the taskrunner (it will create the hooks evertime you start that task).
Or add this to `package.json` (and it will create the hooks after install):

```
"scripts": {
  "postinstall": "grunt githooks"
}
```
