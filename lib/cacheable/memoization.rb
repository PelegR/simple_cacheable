module Cacheable
  module Memoization

    def memoize_cached
      memoize_class do |to_be_cached| 
        extend Memoist    
        memoize *to_be_cached
      end

      memoize_instance
    end

    def memoize_class(&block)
      debugger
      singleton_class.class_exec(class_cached, &block)
    end

    def memoize_instance
      extend Memoist  
      memoize *instance_cached
    end

    def class_cached
      tbc = []
      tbc += cached_class_methods.keys if cached_class_methods?
      tbc.map! { |key| "cached_#{key}".to_sym }
      tbc << :find_cached if cached_key?
      tbc
    end

    def instance_cached
      tbc = []
      tbc += cached_associations if cached_associations?
      tbc += cached_methods if cached_methods?
      tbc.map! { |key| "cached_#{key}".to_sym }
      # tbc + cached_attributes.to_a.map { |key| ["find_cached_all_by_#{key}".to_sym, "find_cached_by_#{key}".to_sym] }.flatten
      tbc
    end

    

    # private :class_cached, :instance_cached
  
  end
end