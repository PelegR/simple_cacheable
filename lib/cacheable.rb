require 'uri'
require 'memoist'
require "cacheable/caches"
require "cacheable/keys"
require "cacheable/expiry"
require "cacheable/memoization"

module Cacheable
  def self.included(base)
    base.extend(Cacheable::Caches)
    base.send :include, Cacheable::Keys
    base.send :include, Cacheable::Expiry
    base.send :extend, Cacheable::Memoization
    base.send :extend,  ClassMethods
    base.class_eval do
      class_attribute   :cached_key,
                        :cached_indices,
                        :cached_methods,
                        :cached_class_methods,
                        :cached_associations
    end
  end

  module ClassMethods
    def model_cache(&block)
      instance_exec &block
      memoize_cached
    end
  end

end