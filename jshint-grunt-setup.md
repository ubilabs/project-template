# Setup jshint as Grunt Task and pre-commit hook

## Grunt task

### Dependencies

* Grunt >4.2.0
* grunt-contrib-jshint ~0.7.*

### Add jshintrc

Add the .jshintrc from [here](https://raw.github.com/ubilabs/ubilabs-project-template/master/.jshintrc) to your project folder and adjust to your needs.

### Grunt setup

Add or modify the jshint task in the Gruntfile.js:

```
jshint: {
  options: {
    jshintrc: true
  },
  build: ['<%= folders.app %>/scripts/**/*js']
}
```

Since we are using the jshint tool for [sublime](https://github.com/ubilabs/SublimeLinter) we only need to setup jshint to run on build. So put your jshint task in the task.run array of you build task.
We can use this task late in the pre-commit hook.

## Pre-commit Hook

We have to add the git hook at least every time we check out a git project since the hook are not included in the repo.

To add a git hook that starts a grunt task (our jshint from above) we use the `grunt-githooks` module.

Add the necessary dependencies to `package.json`:

```
npm install grunt-githooks --save-dev
```

Adjust the `Gruntfile.js` with the new task:

```
githooks: {
  all: {
    'pre-commit': 'jshint',
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
