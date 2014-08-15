require 'docker'
require 'yaml'

class Ansible

  private
  # environment
  @env_name = nil
  # ssh
  @ssh_host = nil
  @ssh_user = nil
  @ssh_keys = nil
  @ssh_port = nil
  # docker
  @docker_img = nil
  @docker_tag = nil
  @docker_run = nil
  @docker_cmd = nil
  @docker_con = nil
  # ansible
  @ansible_host_file = nil

  def initialize
    # validate docker API versions
    if not Docker.validate_version!
      raise "Docker API version and docker-api gem are not compatible"
    end

    begin
      config = YAML.load_file('tests/docker.yml')
      @env_name = config['env_name']
      @ssh_host = config['ssh_host']
      @ssh_user = config['ssh_user']
      @ssh_keys = config['ssh_keys']
      @ssh_port = nil # TODO
      @docker_img = config['docker_img']
      @docker_tag = config['docker_tag']
      @docker_run = config['docker_run']
      @docker_cmd = config['docker_cmd']
    rescue
      raise 'Failed to parse "tests/docker.yml" configuration file'
    end

    if File.writable?('/tmp')
      @ansible_host_file = "/tmp/#{@env_name}.hosts"
    else
      @ansible_host_file = "#{ENV['HOME']}/#{@env_name}.hosts"
    end

    # create a docker container object
    @docker_con = Docker::Container.create(
      'Image' => "#{@docker_img}:#{@docker_tag}",
      'Cmd' => ["#{@docker_cmd}"],
      'Hostname' => @env_name,
      'PortSpecs' => "#{@ssh_port}:22"
    )
  end


  public
  attr_reader :env_name, :ansible_host_file


  # create an Ansible inventory hosts file
  def ansible_hosts_add
    unless File.exists?(@ansible_host_file)
      begin
        f = File.open(@ansible_host_file)
        f.puts "#{@env_name} ansible_connection=ssh ansible_ssh_host=#{@ssh_host} ansible_ssh_user=#{@ssh_user} ansible_ssh_port=#{@ansible_ssh_port} ansible_ssh_private_key_file=#{@ssh_keys}"
      rescue
        raise "Failed to write Ansible inventory data at #{@ansible_host_file}"
      ensure
        File.close(f)
      end
    end
  end

  # remove an Ansible inventory hosts file
  def ansible_hosts_del
    if File.exists?(@ansible_host_file)
      File.unlink(@ansible_host_file)
    end
  end


  # pull the configured base image if not already installed
  def docker_pull
    need_pull = true
    Docker::Image.all.each do |img|
      img.info['RepoTags'].each do |tag|
        if tag.match("#{@docker_img}:#{@docker_tag}")
          need_pull = false
          break
        end
      end
    end
    if need_pull
      Docker::Image.create('fromImage' => @docker_img, 'tag' => @docker_tag)
    end
  end

  def docker_run
    need_run = true
    Docker::Container.all.each do |con|
      con.info['Names'].each do |con_name|
        if con_name.match("/#{@env_name}")
          need_run = false
          break
        end
      end
    end
    if need_run
      @docker_con.run
    end
  end

  def docker_start
    need_start = true
    Docker::Container.all.each do |con|
      con.info['Names'].each do |con_name|
        if con_name.match("/#{@env_name}")
          need_start = false
          break
        end
      end
    end
    if need_start
      @docker_con.start
    end
  end

  # ensure the configured container running
  #   either via docker run
  #   or via docker start
  def docker_go
    docker_run
    docker_start
  end

  # stop a running container for this project
  def docker_stop
    need_stop = false
    Docker::Container.all.each do |con|
      con.info['Names'].each do |con_name|
        if con_name.match("/#{@env_name}")
          need_stop = true
          break
        end
      end
    end
    if need_stop
      @docker_con.stop()
    end
  end

  def docker_rm
    need_rm = false
    Docker::Container.all.each do |con|
      con.info['Names'].each do |con_name|
        if con_name.match("/#{@env_name}")
          need_rm = true
          break
        end
      end
    end
    if need_rm
      @docker_con.remove
    end
  end

end
