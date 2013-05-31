#!/usr/bin/env coffee
use strict"

aseert = require 'assert'
path = require 'path'
fs = require 'fs'

describe "test bumpversion", ()->
    assert = require 'execSync'
    path = require 'path'

    it 'should return sth', (done)->
        tpl2js.compile fixtures_folder, (ret)->
            templates = ret

            done()

    describe 'verify content in templates', ()->
        it 'should has tpl1', ()->
            aseert.ok templates.hasOwnProperty('tpl1')

        it "templates.tpl1 should be identical to tp1.html", ()->
            tpl1 = fs.readFileSync path.join(__dirname, 'fixtures', 'tpl1.html'), 'utf-8'
            aseert.equal tpl1, templates['tpl1']

        it "templates.tpl2 should be identical to tp2.html", ()->
            tpl2 = fs.readFileSync path.join(__dirname, 'fixtures', 'tpl2.html'), 'utf-8'
            aseert.equal tpl2, templates['tpl2']

        it "templates['a.tpl3'] should be identical to tp3.html", ()->
            tpl3 = fs.readFileSync path.join(__dirname, 'fixtures', 'a', 'tpl3.html'), 'utf-8'
            aseert.equal tpl3, templates['a.tpl3']

        it "templates['a.b.tpl4'] should be identical to tp4.html", ()->
            tpl4 = fs.readFileSync path.join(__dirname, 'fixtures', 'a', 'b', 'tpl4.html'), 'utf-8'
            aseert.equal tpl4, templates['a.b.tpl4']