#!/usr/bin/env ruby

require_relative '../lib/haythat'

fields = [Field.new, Field.new]
farm_activity = FarmActivity.new(fields: fields)

GameSimulation
  .new(
    farm_activity: farm_activity
  )
  .start
