# Setup Google Closure Linter Pre-commit Hook

Create a file `git-hooks/pre-commit` in your project with the following content:

```
#!/bin/sh
#
# Pre-commit hooks

# Lint stuff before committing
grunt lint
```

Add the necessary dependencies to `package.json`:

```
npm install grunt-contrib-clean --save-dev
npm install grunt-shell --save-dev
npm install grunt-gjslint --save-dev
```

Adjust the `Gruntfile.js`:

```
  […]
  
    // Clean stuff up
    clean: {
      // Clean any pre-commit hooks in .git/hooks directory
      hooks: ['.git/hooks/pre-commit']
    },

    // Run shell commands
    shell: {
      hooks: {
        // Copy the project's pre-commit hook into .git/hooks
        command: 'cp git-hooks/pre-commit .git/hooks/'
      }
    },
 
    // Lint *.js with the Google Closure Linter 
    gjslint: {
      options: {
        reporter: {
          name: 'console' //report to console
        }
      },
      lib: {
        src: ['app/scripts/*.js']
      }
    }
  
  […]
  
  grunt.registerTask('hookmeup', [
    'clean:hooks',
    'shell:hooks'
  ]);
  
  grunt.registerTask('lint', [
    'gjslint'
  ]);
  
  […]
```

Set up the the npm post install event in `package.json`:

```
  "scripts": {
    "postinstall": "grunt hookmeup"
  }
```
