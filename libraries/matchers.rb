if defined?(ChefSpec)
  def install_err_plugin(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:err_plugin, :install, resource_name)
  end
end
