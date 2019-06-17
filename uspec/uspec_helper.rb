# frozen_string_literal: true

require "bundler/setup"
require "uspec"
Bundler.require :default, :test

Dir.chdir File.dirname(__FILE__)

extend Uspec

require_relative "../lib/toisb"
