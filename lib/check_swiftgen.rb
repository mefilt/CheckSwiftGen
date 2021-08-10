#!/usr/bin/env ruby
#
require 'digest'
require 'json'
require 'find'
require 'yaml'

class CheckSwiftGen

    def cache_invalidate(configuration_file, lock_path) 

        if File.file?("#{configuration_file}") == false       
            puts("Configuration File not found")
            return
        end

        if lock_path.nil? {}
            puts("Please input the lock path")
            return
        end

        text = File.read(configuration_file)
        dictionary = YAML.load(text)

        assets_inputs = []
        if (dictionary.has_key?('xcassets'))
            xcassets = dictionary['xcassets']            
            if (xcassets.has_key?('inputs'))
                assets_inputs = xcassets['inputs']
            end
        end

        strings_inputs = []        
        if (dictionary.has_key?('strings'))
            strings = dictionary['strings']            
            if (strings.has_key?('inputs'))
                strings_inputs = strings['inputs']
            end
        end

        return exist_new_files(
                    assets_hash(assets_inputs),
                    strings_hash(strings_inputs),
                    lock_path
                )
    end

    def exist_new_files(assets_map, strings_map, lock_path)

        tmp_name_file = "SwiftGen.tmp.lock"
        lock_name_file = "SwiftGen.lock"
        
        tmp_path_file = lock_path + "/" + tmp_name_file
        lock_path_file = lock_path + "/" + lock_name_file

        lock_file = Hash.new        
        lock_file["assets"] = assets_map
        lock_file["strings"] = strings_map


        if File.file?("#{tmp_path_file}")       
            File.delete(tmp_path_file)
        end

        File.write(tmp_path_file, lock_file.to_json)
        new_hash = Digest::SHA512.file tmp_path_file    
        File.delete(tmp_path_file)
        
        old_hash = ""
        if File.file?("#{lock_path_file}")        
            old_hash = Digest::SHA512.file "#{lock_path_file}"  
        end

        if old_hash != new_hash 
            old_hash = new_hash
            File.write(lock_path_file, lock_file.to_json)    
            return true
        else 
            return false
        end
    end

    def assets_hash(assets_file_paths) 
        assets_map = Hash.new
        assets_file_paths.each do |asset_file_paths|
    
            files = Find.find(asset_file_paths).select { |p| /.*\.json$/ =~ p }
            asset_map = Hash.new
                
            files.each do |img_file|
                sha512 = Digest::SHA512.file img_file
                asset_map[img_file] = sha512
            end

            assets_map[asset_file_paths] = asset_map
        end

        return assets_map
    end

    def strings_hash(strings_file_paths) 
        strings_map = Hash.new
        strings_file_paths.each do |string|
            keys = string.split('/')[-2] + "/" + string.split('/').last
            sha512 = Digest::SHA512.file string
            strings_map[keys] = sha512
        end
        return strings_map
    end
end



