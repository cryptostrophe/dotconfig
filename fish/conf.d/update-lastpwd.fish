function update-lastpwd --on-variable PWD
    echo "$PWD" >$__fish_user_data_dir/last_pwd
end
