class zsh($user="vagrant") {
  class { "zsh::update": 
    user => $user,
  }
}
