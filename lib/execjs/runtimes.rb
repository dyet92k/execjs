module ExecJS
  module Runtimes
    def self.best_available
      runtimes.find(&:available?)
    end

    def self.runtimes
      @runtimes ||= []
    end

    def self.define_runtime(name, options)
      runtimes.push runtime = Runtime.new(options)
      const_set(name, runtime)
    end

    def self.runner_path(path)
      File.expand_path("../runtimes/#{path}", __FILE__)
    end

    define_runtime :V8,
      :command => "v8",
      :runner_path => runner_path("basic.js")

    define_runtime :Node,
      :command => "node",
      :runner_path => runner_path("node.js")

    define_runtime :JSC,
      :command => "/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc",
      :runner_path => runner_path("basic.js")

    define_runtime :Spidermonkey,
      :command => "js",
      :runner_path => runner_path("basic.js")
  end
end
