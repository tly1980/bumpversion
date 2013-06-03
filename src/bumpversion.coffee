#!/usr/bin/env coffee
'''
bumpversion will assume you always use git flow or hubflow.
if you dont use git flow or hubflow, use -m and you have provide the version number.
bumpversion should be called after you created a release branch.
Basically, it will produce a VERSION.json in following structure:
{
	"main": # take from the current branch
	"cache": # a self increment int. +1 everytime you call bumpversion
	"timestamp": # timestamp,
	"last_2_commits": # last 2 git commit
}
'''



try
	BV_VERSION = require('./bumpversion_VERSION.json')
catch error
	BV_VERSION = {main: 'r0.1'}	
		

execSync = require 'execSync'
fs = require 'fs'
path = require 'path'

# preparing the ArgParser
ArgumentParser= require('argparse').ArgumentParser

parser = new ArgumentParser { 
	version: BV_VERSION.main, 
	addHelp: true, 
	description: 'A tool to generate / bump the version to a JSON file.'
}

parser.addArgument ['-m'], { help: 'Update the main version. If you do not specify version number, Main version will be take it as git branch by default.'}

parser.addArgument ['-c'], { action: 'store', type: 'int', help: 'Update the cache version. If you not specify version number, it would be a self increment number' }

parser.addArgument ['-q'], {help: 'quiet mode.', action: 'storeTrue'}

parser.addArgument ['-lc'], { action: 'store', type: 'int', default: 0, help: 'Update the last default commit'}


args = parser.parseArgs()


VERSION =
	cache: 1
	timestamp: new Date()

VERSION.main = args.m
VERSION.main = execSync.exec("git rev-parse --abbrev-ref HEAD").stdout.replace('\n', '') if args.m == null 

#console.log 'args', args

if args.c == null
	try
		OLD_VERSION_PATH = path.resolve(process.cwd(), './VERSION.json')
		OLD_VERSION = require OLD_VERSION_PATH
		VERSION.cache = OLD_VERSION.cache + 1
	catch exception
		console.log "OLD_VERSION is not existed, will create new one"
else
	VERSION.cache = args.c

if args.lc > 0
	ret = execSync.exec("git log -" + args.lc + " --pretty=oneline")
	VERSION.last_commits = (i for i in ret.stdout.split('\n') when i isnt '')

fs.writeFileSync './VERSION.json', JSON.stringify(VERSION, null, 4)

console.log 'version bumped to:\n ' + JSON.stringify(VERSION, null, 4) if args.q != yes