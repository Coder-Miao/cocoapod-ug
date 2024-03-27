module Pod
    class Command
        class Uginstall < Command
            self.summary = 'cocoapods plugin for ugreen'
            
            self.description = <<-DESC
            ugreen solves the problem of native and flutter source debugging.
            DESC
            
            self.arguments = [
            CLAide::Argument.new('NAME', false)
            ]
        end
        
        def replace_podfile_with(file_name)
            target_file = 'Podfile'
            
            # 读取指定文件的内容
            replacement_content = File.read(file_name)
            
            # 将指定文件的内容替换到 Podfile 中
            File.open(target_file, 'w') do |file|
                file.puts replacement_content
            end
            
            UI.puts "Replaced #{target_file} with #{file_name}"
            
            # 执行 pod install
            system('pod install')
        end
        
        def has_flutter_branch?
            # 执行 git branch 命令获取当前分支的名称
            branch_name = `git rev-parse --abbrev-ref HEAD`.strip
            
            # 判断分支名称是否包含 "flutter" 字段
            branch_name.include?("flutter")
        end
        
        def run
            param = arguments.named_params['NAME']
            
            if param.nil?
                # 没有参数则走原来的逻辑
                if has_flutter_branch?
                    replace_podfile_with('podfile_flutter')
                else
                    replace_podfile_with('podfile_dev')
                end
            else
                # 根据参数调用对应的方法
                case param
                    when 'native'
                    replace_podfile_with('podfile_dev')
                    when 'flutter'
                    replace_podfile_with('podfile_flutter')
                    else
                    UI.puts "Invalid parameter. Please use 'native' or 'flutter'."
                end
            end
        end
    end
end
