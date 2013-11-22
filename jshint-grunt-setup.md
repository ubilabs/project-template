# Setup jshint as Grunt Task and pre-commit hook

## Dependencies

* Grunt >4.2.0
* grunt-contrib-jshint ~0.7.*

## Setup

Add or modify the jshint task in the Gruntfile.js:

```
jshint: {
  options: {
    jshintrc: true
  },
  build: ['<%= folders.app %>/scripts/**/*js']
}
```

Since we are using the jshint tool for [sublime](https://github.com/ubilabs/SublimeLinter) we only need to setup jshint to run on build.

So put your jshint task in the task.run array of you build task.





# Setup jshint Pre-commit Hook

Add the necessary dependencies to `package.json`:

```
npm install grunt-githooks --save-dev
```

Adjust the `Gruntfile.js`:

```
githooks: {
  all: {
    'pre-commit': 'jshint',
  }
},
```

Add githooks task to the taskrunner (it will create the hooks evertime). Or add this to `package.json` (and it will create the hooks after install):

```
"scripts": {
  "postinstall": "grunt githooks"
}
```