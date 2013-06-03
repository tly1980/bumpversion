#!/usr/bin/env coffee
"use strict"

assert = require 'assert'
path = require 'path'
fs = require 'fs'
execSync = require 'execSync'

loadJSON = (fpath)->
    content = fs.readFileSync fpath, 'utf8'
    return JSON.parse content

describe "test bumpversion", ()->
    describe "specifying all the parameters: (bumpversion -lc 4 -m mainVERSION -c 999)", ()->
        execSync.exec("cd " + __dirname + " && rm -f VERSION.json")
        ret = execSync.exec("cd " + __dirname + " && node ../bin/bumpversion -lc 4 -m mainVERSION -c 999")
        VERSION = loadJSON(path.resolve(__dirname, './VERSION.json'))

        it "cache shold bump to 999", ()->
            assert.equal VERSION.cache, 999

        it "cache shold bump to 999", ()->
            assert.equal VERSION.main, 'mainVERSION'

        it "last_commits length should be 4", ()->                
            assert.equal VERSION.last_commits.length, 4


    describe "specifying no the: (bumpversion)", ()->
        ret = execSync.exec("cd " + __dirname + " && node ../bin/bumpversion")
        
        VERSION2 = loadJSON(path.resolve(__dirname, './VERSION.json'))
        current_branch = execSync.exec("git rev-parse --abbrev-ref HEAD").stdout.replace('\n', '')

        it "cache shold bump to 1000", ()->
            assert.equal VERSION2.cache, 1000

        it "main version should take current branch:" + current_branch, ()->
            assert.equal VERSION2.main, current_branch

        it "should have no last_commits", ()->                
            assert.equal VERSION2.last_commits, undefined 

        execSync.exec("cd " + __dirname + " && rm -f VERSION.json")