$user = "vagrant"

class zsh::update($user) {
  $repo = "http://github.com/rafael/oh-my-zsh"

  Exec { 
    path => ["/bin", "/usr/bin", "/usr/local/bin"], 
    user => $user,
    group => $user,
    require => Class["git::install"], 
  }

  exec { "update-zsh":
    cwd => "/home/$user/.oh-my-zsh",
    command => "git pull origin master",
    onlyif  => "[ -s /home/$user/.oh-my-zsh ]",
  }

  exec { "install-zsh":
    cwd => "/home/$user",
    command => "git clone $repo .oh-my-zsh",
    creates => "/home/$user/.oh-my-zsh",
  }

  file { "/home/$user/.zshrc":
    owner => $user,
    group => $user,
    ensure => link,
    target => "/home/$user/.oh-my-zsh/templates/zshrc.zsh-template",
    require => Exec["install-zsh"],
  }
}
