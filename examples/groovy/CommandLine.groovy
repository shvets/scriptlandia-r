#!/usr/bin/env groovy

println("Command line arguments:")

for (a in this.args) {
  println("  " + a)
}