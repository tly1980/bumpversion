// Generated by CoffeeScript 1.6.2
(function() {
  "use strict";
  var assert, execSync, fs, loadJSON, path;

  assert = require('assert');

  path = require('path');

  fs = require('fs');

  execSync = require('execSync');

  loadJSON = function(fpath) {
    var content;

    content = fs.readFileSync(fpath, 'utf8');
    return JSON.parse(content);
  };

  describe("test bumpversion", function() {
    describe("specifying all the parameters: (bumpversion -lc 4 -m mainVERSION -c 999)", function() {
      var VERSION, ret;

      execSync.exec("cd " + __dirname + " && rm -f VERSION.json");
      ret = execSync.exec("cd " + __dirname + " && node ../bin/bumpversion -lc 4 -m mainVERSION -c 999");
      VERSION = loadJSON(path.resolve(__dirname, './VERSION.json'));
      it("cache shold bump to 999", function() {
        return assert.equal(VERSION.cache, 999);
      });
      it("cache shold bump to 999", function() {
        return assert.equal(VERSION.main, 'mainVERSION');
      });
      return it("last_commits length should be 4", function() {
        return assert.equal(VERSION.last_commits.length, 4);
      });
    });
    return describe("specifying no the: (bumpversion)", function() {
      var VERSION2, current_branch, ret;

      ret = execSync.exec("cd " + __dirname + " && node ../bin/bumpversion");
      VERSION2 = loadJSON(path.resolve(__dirname, './VERSION.json'));
      current_branch = execSync.exec("git rev-parse --abbrev-ref HEAD").stdout.replace('\n', '');
      it("cache shold bump to 1000", function() {
        return assert.equal(VERSION2.cache, 1000);
      });
      it("main version should take current branch:" + current_branch, function() {
        return assert.equal(VERSION2.main, current_branch);
      });
      it("should have no last_commits", function() {
        return assert.equal(VERSION2.last_commits, void 0);
      });
      return execSync.exec("cd " + __dirname + " && rm -f VERSION.json");
    });
  });

}).call(this);
