'use strict';                   // globalstrict

var a = 1,
  b = 2,
  duck_case = 1,                // camelcase
  c;

duck_case++;

duck_case++;                    // jshint ignore:line

c = a & b;                      // bitwise

if (a < b) return;              // curly

if (a == b) { return; }         // eqeqeq

for (a in b) {                  // forin: false
    c();                        // indent: 2
}

a = function() {}();            // immed: true

f();
function f() {}                 // latedef: true

c = new klass();                // newcap: true

function f() {
  var a = arguments.caller,     // noarg
    b = arguments.callee;

  a += b;
}

if (a == b) {
} else {                        // noempty: true
  a++;                          // plusplus: false
}

a = "quote";                    // quotmark: single

function unused(argument) {     // unused
  undef = 1;                    // undef
}

function Klass() {}

a = Klass();                    // nonew

a++;                            /* trailing */

function f(a, b, c, d) {        // maxparams: 3
  a = b + c + d;
}

function f() {
  if (true) {
    if (true) {
      if (true) {
        if (true) {             // maxdepth: 3
          a++;
        }
      }
    }
  }
}

function f() {                  // maxstatements: 15
  a++;
  a++;
  a++;
  a++;
  a++;
  a++;
  a++;
  a++;
  a++;
  a++;
  a++;
  a++;
  a++;
  a++;
  a++;
  a++;
}

function f() {                   // maxcomplexity: 7

  if (true) {
    b++;
  }
  if (true) {
    b++;
  }
  if (true) {
    b++;
  }
  if (true) {
    b++;
  }
  if (true) {
    b++;
  }
  if (true) {
    b++;
  }
  if (true) {
    b++;
  }
}

a++;                            // maxlen: 80,     max number of characters per line

a++                             // asi - Automatic Semicolon Insertion

if (a = b) {                    // boss - comparisons would be expected
  a++;
}

debugger;                       // debug

if (a == null) {                // eqnull
  a++;
}

a = eval('b');                  // evil

function f() {
  if (true) {
    var x = 0;
    x++;
  }

  x++;                          // funcscope
}

a && a.b();                     // expr

a.__iterator__ = f;             // iterator

if (true) { a++ }               // lastsemic

a = b                           // laxbreak
  + 1;

function f(argument) {
  var a
    ,b                          // laxcomma
    ;

  a = b + c;
}

for (a = 0; a < 10; a++) {
  a.callback(function() {
    b++;                        // loopfunc: true
  });
}

a = 'Multi\
Line';                          // multistr

a.__proto__ = b;                // proto

a.href = 'javascript:void';     // scripturl

a++;           	              	// smarttabs

function f(argument) {
  var x = 1;
  var x = 2;                    // shadow
  x++;
}

a['b'] = b;                     // sub

a = new function() {            // supernew
  this.b = 1;
};

function f() {
  this.a++;                     // validthis
}

xyz.a();
window.a++;                     // browser: true
alert(a);                       // devel: true
require('a');                   // node: true
a = escape('b');                // nonstandard: false
a = $('a');                     // predef

function f() {
  this._a = 'a';                // nomen
}

function f() {
  var a;
  var b;                        // onevar

  a = a + b;
}

function f() {                  // white: true
  a++;
}

a = function () {               // gcl: true
  a++;
};
