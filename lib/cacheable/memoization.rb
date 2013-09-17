module Cacheable
  module Memoization
    
    class_eval do 
      extend memoist
      memoize :find_cached
    end

    

        

  end
end