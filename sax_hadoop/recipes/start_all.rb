
hadoop_package_name = ::File.basename(node['sax_hadoop']['source'])
hadoop_extracted_dir = hadoop_package_name.sub(/[.](tar[.]gz|tgz)$/, '')

install_dir = node['sax_hadoop']['hadoop_install_loc']
user_pwd = node['sax_hadoop']['user_pwd']
hadoop_tar_path = "#{install_dir}/#{hadoop_package_name}"
hadoop_extracted_path = "#{install_dir}/#{hadoop_extracted_dir}"


bash 'starting hadoop services' do
  user node['sax_hadoop']['owner']
  cwd "#{hadoop_extracted_path}/etc/hadoop"
  code <<-EOH
    sshpass -p #{user_pwd} ssh -o StrictHostKeyChecking=no #{node['sax_hadoop']['username']}@#{node['fqdn']} "cd #{hadoop_extracted_path}/sbin;start-all.sh"
    EOH
end
