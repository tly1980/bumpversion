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

parser.addArgument ['-lc'], { action: 'store', type: 'int', defaultValue: 0, help: 'Update the last default commit'}

parser.addArgument ['-f'], { action: 'store', defaultValue: 'VERSION.json', help: 'The file to store JSON'}

parser.addArgument ['-x'], { action: 'store', defaultValue: '', help: 'Exclude the fields to be updated. Could be "m", "c" or "mc".'}


args = parser.parseArgs()

loadJSON = (fpath)->
    content = fs.readFileSync fpath, 'utf8'
    return JSON.parse content

VERSION =
	cache: 1
	timestamp: new Date()

VERSION.main = args.m
VERSION.main = execSync.exec("git rev-parse --abbrev-ref HEAD").stdout.replace('\n', '') if args.m == null 

console.log 'args', args

VERSION_PATH = path.resolve(process.cwd(), args.f)

console.log "VERSION_PATH", VERSION_PATH

if args.c == null
	try
		OLD_VERSION = loadJSON VERSION_PATH
		VERSION.cache = OLD_VERSION.cache + 1
	catch exception
		console.log "OLD_VERSION is not existed, will create new one"
else
	VERSION.cache = args.c

if args.lc > 0
	ret = execSync.exec("git log -" + args.lc + " --pretty=oneline")
	VERSION.last_commits = (i for i in ret.stdout.split('\n') when i isnt '')

if 'c' in args.x
	if (OLD_VERSION?)
		VERSION.cache = OLD_VERSION.cache

if 'm' in args.x
	if (OLD_VERSION?)
		VERSION.main = OLD_VERSION.main

fs.writeFileSync VERSION_PATH, JSON.stringify(VERSION, null, 4)

console.log 'version bumped to:\n' + JSON.stringify(VERSION, null, 4) + '\n and save to : ' + VERSION_PATH  if args.q != yes
