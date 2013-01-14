#
# THIS FILE IS AUTOMATICALLY GENERATED.  EDIT scalar_scanner.rl INSTEAD
#
# To compile:      ragel -R -L scalar_scanner.rl
# To generate svg: ragel -R -V -p scalar_scanner.rl | dot -Tsvg -o scalar_scanner.svg
#

=begin
%%{
  machine yaml_scalar_scanner;

  ###
  # Actions
  action on_null_value      { return parse_null_value string      }
  action on_bool_true       { return parse_bool_true string       }
  action on_bool_false      { return parse_bool_false string      }
  action on_int_base_2      { return parse_int_base_2 string      }
  action on_int_base_8      { return parse_int_base_8 string      }
  action on_int_base_10     { return parse_int_base_10 string     }
  action on_int_base_16     { return parse_int_base_16 string     }
  action on_int_base_60     { return parse_int_base_60 string     }
  action on_float_base_10   { return parse_float_base_10 string   }
  action on_float_base_60   { return parse_float_base_60 string   }
  action on_float_inf       { return parse_float_inf string       }
  action on_float_nan       { return parse_float_nan string       }
  action on_time_ymd        { return parse_time_ymd string        }
  action on_time_full       { return parse_time_full string       }
  action on_symbol_quoted   { return parse_symbol_quoted string   }
  action on_symbol_unquoted { return parse_symbol_unquoted string }
  action on_string          { return parse_string string          }

  ###
  # Null - http://yaml.org/type/null.html
  null_value = ('~'|'null'|'Null'|'NULL') %on_null_value ;

  ###
  # Boolean - http://yaml.org/type/bool.html
  bool_true  = ('yes'|'Yes'|'YES'|'true'|'True'|'TRUE'|'on'|'On'|'ON') %on_bool_true ; # NOTE: 'y'|'Y' removed from YAML spec
  bool_false = ('no'|'No'|'NO'|'false'|'False'|'FALSE'|'off'|'Off'|'OFF') %on_bool_false ; # NOTE: 'n'|'N' removed from YAML spec

  bool = bool_true | bool_false ;

  ###
  # Integer - http://yaml.org/type/int.html
  int_base_2  = [\-+]?'0b'[0-1_]+ %on_int_base_2 ;
  int_base_8  = [\-+]?'0'[0-7_]+ %on_int_base_8 ;
  int_base_10 = [\-+]?('0'|[1-9][0-9_,]*) %on_int_base_10 ; # NOTE: comma not in YAML spec
  int_base_16 = [\-+]?'0x'[0-9a-fA-F_,]+ %on_int_base_16 ; # NOTE: comma not in YAML spec
  int_base_60 = [\-+]?[0-9][0-9_]*(':'[0-5]?[0-9])+ %on_int_base_60 ; # NOTE: YAML spec has leading digit as [1-9]

  int = int_base_2 | int_base_8 | int_base_10 | int_base_16 | int_base_60 ;

  ###
  # Float - http://yaml.org/type/float.html
  float_base_10 = [\-+]?([0-9][0-9_,]*)?'.'[0-9]*([eE][\-+][0-9]+)? %on_float_base_10 ; # NOTE: comma not in YAML spec; dot removed from [0-9.] after initial decimal point
  float_base_60 = [\-+]?[0-9][0-9_]*(':'[0-5]?[0-9])+'.'[0-9_]* %on_float_base_60 ;
  float_inf     = [\-+]?'.'('inf'|'Inf'|'INF') %on_float_inf ;
  float_nan     = '.'('nan'|'NaN'|'NAN') %on_float_nan ;

  float = float_base_10 | float_base_60 | float_inf | float_nan ;

  ###
  # Time - http://yaml.org/type/timestamp.html
  time_ymd  = [0-9][0-9][0-9][0-9]'-'('1'[012]|'0'[0-9]|[0-9])'-'([12][0-9]|'3'[01]|'0'[0-9]|[0-9]) %on_time_ymd ;
  # NOTE: YAML spec originally [0-9][0-9][0-9][0-9]'-'[0-9][0-9]'-'[0-9][0-9]
  #   - Individual date portions were made more explicit

  time_full = [0-9][0-9][0-9][0-9]'-'[0-9][0-9]?'-'[0-9][0-9]?([Tt]|[ \t]+)[0-9][0-9]?':'[0-9][0-9]':'[0-9][0-9]('.'[0-9]*)?([ \t]*('Z'|[\-+][0-9][0-9]?(':'?[0-9][0-9])?))? %on_time_full ;
  # NOTE: YAML spec originally [0-9][0-9][0-9][0-9]'-'[0-9][0-9]?'-'[0-9][0-9]?([Tt]|[ \t]+)[0-9][0-9]?':'[0-9][0-9]':'[0-9][0-9]('.'[0-9]*)?(([ \t]*)'Z'|sign[0-9][0-9]?(':'[0-9][0-9])?)? %on_time_full ;
  #   - Spacing before time zone was moved to not only be before Z, but to also
  #     be before the numeric time zone.
  #   - Colon in time zone made optional

  time = time_ymd | time_full;

  ###
  # Symbol
  symbol_quoted   = ':'['"] @on_symbol_quoted ;
  symbol_unquoted = ':'[^'"] @on_symbol_unquoted ;

  symbol = symbol_quoted | symbol_unquoted ;


  main := (null_value | bool | int | float | time | symbol) $!on_string ;
}%%
=end

module Psych
  ###
  # Scan scalars for built in types
  class ScalarScanner
    ###
    # START OF SCANNER DATA STRUCTURES
    %% write data;
    # %% this just fixes our syntax highlighting...
    # END OF SCANNER DATA STRUCTURES
    ###

    def initialize
      @string_cache = {}
      @symbol_cache = {}
    end

    def tokenize string
      return nil if string.empty?
      return string if @string_cache.key?(string)
      return @symbol_cache[string] if @symbol_cache.key?(string)

      data = string_to_data(string)
      eof = data.length

      ###
      # START OF SCANNER INITIALIZATION
      %% write init;
      # %% this just fixes our syntax highlighting...
      # END OF SCANNER INITIALIZATION
      ###

      ###
      # START OF SCANNER EXECUTION
      %% write exec;
      # %% this just fixes our syntax highlighting...
      # END OF SCANNER EXECUTION
      ###
    end

    def parse_time string
      parse_time_full string
    end

    private

    # Instance methods to expose scanner methods defined at the class level
    def _yaml_scalar_scanner_actions;        self.class.send(:_yaml_scalar_scanner_actions);        end
    def _yaml_scalar_scanner_key_offsets;    self.class.send(:_yaml_scalar_scanner_key_offsets);    end
    def _yaml_scalar_scanner_trans_keys;     self.class.send(:_yaml_scalar_scanner_trans_keys);     end
    def _yaml_scalar_scanner_single_lengths; self.class.send(:_yaml_scalar_scanner_single_lengths); end
    def _yaml_scalar_scanner_range_lengths;  self.class.send(:_yaml_scalar_scanner_range_lengths);  end
    def _yaml_scalar_scanner_index_offsets;  self.class.send(:_yaml_scalar_scanner_index_offsets);  end
    def _yaml_scalar_scanner_indicies;       self.class.send(:_yaml_scalar_scanner_indicies);       end
    def _yaml_scalar_scanner_trans_targs;    self.class.send(:_yaml_scalar_scanner_trans_targs);    end
    def _yaml_scalar_scanner_trans_actions;  self.class.send(:_yaml_scalar_scanner_trans_actions);  end
    def _yaml_scalar_scanner_eof_actions;    self.class.send(:_yaml_scalar_scanner_eof_actions);    end
    def yaml_scalar_scanner_start;           self.class.yaml_scalar_scanner_start;                  end
    def yaml_scalar_scanner_first_final;     self.class.yaml_scalar_scanner_first_final;            end
    def yaml_scalar_scanner_error;           self.class.yaml_scalar_scanner_error;                  end
    def yaml_scalar_scanner_en_main;         self.class.yaml_scalar_scanner_en_main;                end

    def data_to_string data, ts, te
      data[ts..te].pack("c*")
    end

    def string_to_data string
      string.unpack("c*")
    end

    def parse_null_value string
      nil
    end

    def parse_bool_true string
      true
    end

    def parse_bool_false string
      false
    end

    def parse_int_base_10 string
      Integer(string.gsub(/[,_]/, ''))
    rescue
      parse_string string
    end
    alias parse_int_base_2  parse_int_base_10
    alias parse_int_base_8  parse_int_base_10
    alias parse_int_base_16 parse_int_base_10

    def parse_int_base_60 string
      i = 0
      string.split(':').each_with_index do |n,e|
        i += (n.to_i * 60 ** (e - 2).abs)
      end
      i
    end

    def parse_float_base_10 string
      Float(string.gsub(/[,_]|\.$/, ''))
    rescue
      parse_string string
    end

    def parse_float_base_60 string
      i = 0
      string.split(':').each_with_index do |n,e|
        i += (n.to_f * 60 ** (e - 2).abs)
      end
      i
    end

    def parse_float_inf string
      if string[0] == '-'
        -1 / 0.0
      else
        1 / 0.0
      end
    end

    def parse_float_nan string
      0.0 / 0.0
    end

    def parse_time_ymd string
      require 'date'
      Date.strptime(string, '%Y-%m-%d')
    rescue
      parse_string string
    end

    def parse_time_full string
      date, time = *(string.split(/[ tT]/, 2))
      (yy, m, dd) = date.split('-').map { |x| x.to_i }
      md = time.match(/(\d+:\d+:\d+)(?:\.(\d*))?\s*(Z|[-+]\d+(:\d\d)?)?/)

      (hh, mm, ss) = md[1].split(':').map { |x| x.to_i }
      us = (md[2] ? Rational("0.#{md[2]}") : 0) * 1000000

      time = Time.utc(yy, m, dd, hh, mm, ss, us)

      return time if 'Z' == md[3]
      return Time.at(time.to_i, us) unless md[3]

      tz = md[3].match(/^([+\-]?\d{1,2})\:?(\d{1,2})?$/)[1..-1].compact.map { |digit| Integer(digit, 10) }
      offset = tz.first * 3600

      if offset < 0
        offset -= ((tz[1] || 0) * 60)
      else
        offset += ((tz[1] || 0) * 60)
      end

      Time.at((time - offset).to_i, us)
    rescue
      parse_string string
    end

    def parse_symbol_quoted string
      last = string[-1]
      return string unless last == '"' || last == "'"
      @symbol_cache[string] = string[2..-2].to_sym
    rescue
      parse_string string
    end

    def parse_symbol_unquoted string
      @symbol_cache[string] = string[1..-1].to_sym
    rescue
      parse_string string
    end

    def parse_string string
      @string_cache[string] = true
      string
    end
  end
end

if $0 == __FILE__
  scanner = Psych::ScalarScanner.new
  loop do
    print "> "
    string = gets.strip
    break if string == "exit"
    puts " => #{scanner.tokenize(string).inspect}"
  end
end