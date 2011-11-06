class zsh($user="vagrant") {
  class { "bash::update": 
    user => $user,
  }
}
