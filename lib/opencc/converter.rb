module OpenCC
  class Converter
    ENCODING = Encoding::UTF_8.to_s
    
    include OpenCC

    class << self
      def with(cfg)
        converter = new(cfg)
        yield converter
      ensure
        converter.close
      end
    end
    
    attr_reader :cfg, :ocid

    # *<tt>:cfg</tt> - The config file name without .json suffix, default "s2t"
    #   [s2t|t2s|s2tw|tw2s|s2hk|hk2s|s2twp|tw2sp|t2tw|hk2t|t2hk|t2jp|jp2t|tw2t]
    def initialize(cfg = :s2t)
      @cfg    = cfg
      @closed = false
      @mutex  = Mutex.new
    end

    def convert(input)
      synchronize do
        return if closed?
        
        @ocid ||= opencc_open(cfg_file_name)

        if ocid
          opencc_convert(ocid, input).force_encoding(ENCODING)
        end
      end
    end

    # It will raise an +RuntimeError+ exception if can not make an instance of OpenCC.
    def convert!(input)
      synchronize do
        return if closed?
        
        @ocid ||= opencc_open(cfg_file_name)
        
        if @ocid.nil?
          raise RuntimeError, "Can not make an instance of OpenCC with configuration file #{cfg_file_name}"
        end

        opencc_convert(ocid, input).force_encoding(ENCODING)
      end
    end

    def close
      synchronize do
        return false if closed?
        return false if ocid.nil?
        
        if opencc_close(ocid)
          @ocid = nil
          @closed = true
        end
      end
    end

    def closed?
      @closed
    end

    private

    def synchronize(&block)
      @mutex.synchronize(&block)
    end

    def cfg_file_name
      @cfg && "#{@cfg}.json"
    end
  end
end